<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="ext" uri="/ext-tags"%>
<%@ taglib prefix="app" uri="/app-tags"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<ext:ui >
	<ext:script before="true">
	function beforeDSLoad(){
		//alert(deptCodeTreeSelect);
		ds1.baseParams['paramValue.creatorDept']='${deptCode}';
	}
	var ds1 = new Ext.data.JsonStore({
			url: '../sysparam/findByParamValue.action?paramValue.paramId=13' ,
			root: 'paramValues',
			fields:['id', 'paramId', 'paramValue', 'parentId', 'describe', 'creator', 'createDate']
		});
		ds1.on('beforeload',beforeDSLoad );
		ds1.load();	
	var ds = new Ext.data.JsonStore({
			url: '../sysparam/findByParamValue.action?paramValue.paramId=13' ,
			root: 'paramValues',
			fields:['id', 'paramId', 'paramValue', 'parentId', 'describe', 'creator', 'createDate']
		});
		ds.load();	
		
	var userGroupStore = new Ext.data.JsonStore({
			url: '../exagroup/findByExaGroup.action' ,
			root: 'exaGroups',
			fields:['id','groupId', 'groupName', 'parentId', 'groupDesc', 'deptCode', 'code']
		});
		userGroupStore.load();	
		
	var examtype = new Ext.data.JsonStore({
			url: '../sysparam/findByParamValue.action?paramValue.paramId=4' ,
			root: 'paramValues',
			fields:['id', 'paramId', 'paramValue', 'parentId', 'describe', 'creator', 'createDate']
		});
		examtype.load();
		var createMethodStore = new Ext.data.JsonStore({
				url: '../sysparam/findByParamValue.action?paramValue.paramId=5' ,
				root: 'paramValues',
				fields:['id', 'paramId', 'paramValue', 'parentId', 'describe', 'creator', 'createDate']
			});		
	    createMethodStore.load();	
	    var paperStore_1 = new Ext.data.JsonStore({
			url: '../sysparam/findByParamValue.action?paramValue.paramId=12' ,
			root: 'paramValues',
			fields:['id', 'paramId', 'paramValue', 'parentId', 'describe', 'creator', 'createDate']
		});
		paperStore_1.load(); 
		
		var queryUserByDeptCodeStore = new Ext.data.JsonStore({
				url: '../queryUserByDept/findPageByQueryUserbyDeptCode.action' ,
				root: 'queryUserbyDeptCodes',
				fields:['userId', 'username', 'empId', 'empCode', 'empName', 'deptId', 'deptName', 'deptCode', 'userEmail']
			});
	  function	makeSubmitValue(){
	  if(exaExamArrange_examName.getRawValue().substring(0,4)=="自主考试"){
		  exaExamArrange_examNameId.setValue(exaExamArrange_examName.getValue());
	      exaExamArrange_selfDefExamNameRemarks.setValue("1");
	      //alert(exaExamArrange_examName.getValue()+":value:Rawvalue:"+exaExamArrange_examName.getRawValue());
		  exaExamArrange_selfDef_examName_copy.show();	    
	  }else{
		  exaExamArrange_examNameId.setValue(exaExamArrange_selfDef_examName.getValue());
		  exaExamArrange_examNameId.setValue(exaExamArrange_examName.getValue());	      
	      exaExamArrange_selfDefExamNameRemarks.setValue("0");
	      //alert(exaExamArrange_examName.getValue()+":value:Rawvalue:"+exaExamArrange_examName.getRawValue());
		  
		  exaExamArrange_selfDef_examName_copy.hide();		  
	  }
	  };
	  
	  function onResetQueryView() {
			queryView.getForm().reset();
			
		}
		
	 function renderGroupName(value){
             // 通过匹配value取得ds索引 
             var  index= userGroupStore.find(exaExamRelative_groupId_to_show.valueField,value);
             var  groupNameRecord  =  userGroupStore.getAt(index);
             // 返回记录集中的value字段的值 
             var  returnvalue  =   "" ;
             if  (groupNameRecord) 
                 {
                   returnvalue  =  groupNameRecord.data.groupName;
                   } 
             return  returnvalue; 
        } 
		
	</ext:script>
	<ext:viewport layout="border">
		<ext:items>
			<ext:panel region="west"  frame="false" autoScroll="true" width="210">
				<ext:items>
					<ext:treePanel var="userTree1"  frame="false"  autoScroll="true" height="350"   width="190">
						 <ext:treeLoader var="userTreeLoader" clearOnLoad="true" url="../sysparam/findDeptTree.action" idField="deptCode" textField="deptName" handler="selectDept1" listeners="{beforeload:KK1}" />
						<ext:asyncTreeNode text="总部" id="001" listeners="{click:rootselected2}"/>
			  		 </ext:treePanel>	
					<ext:treePanel  var="distree" collapsible="true"   autoScroll="true" height="350"  width="190">
						<ext:tbar>
							<app:isPermission code="/testpool/addTestPool.action"><ext:button text="${app:i18n_menu_def('testPool.button.add.name', app:i18n('add'))}" var="btnAddDir" handler="btnAddDir"/></app:isPermission>
							<app:isPermission code="/testpool/editTestPool.action"><ext:button text="${app:i18n_menu_def('testPool.button.edit.name', app:i18n('edit'))}" var="btnEditDir" handler="btnEditDir"/></app:isPermission>
							<app:isPermission code="/testpool/deleteTestPool.action"><ext:button text="${app:i18n_menu_def('testPool.button.delete.name', app:i18n('delete'))}" var="btnDeleteDir" handler="btnDeleteDir"/></app:isPermission>		    		
				    	</ext:tbar>			    		 
				    		<ext:treeLoader var="distree1"  clearOnLoad="true" url="../sysparam/paramValueTreeByDataRole.action?paramid=13" idField="id" textField="paramValue" handler="onSelectNode" listeners="{beforeload:setParams}"/>
							<ext:asyncTreeNode var="distreeLoaderNode" text="${app:i18n('exaExamArrange')}" id="45" />					 
					</ext:treePanel>	
				</ext:items>
			</ext:panel>
			
			<ext:panel region="center" layout="border" frame="true">
				<ext:tbar>
					<app:isPermission code="/testarrange/searchExaExamArrange.action"><ext:button text="${app:i18n_menu_def('exaExamArrange.button.search.name', app:i18n('search'))}" var="btnSearch" handler="onSearch"/></app:isPermission>
					<app:isPermission code="/testarrange/addExaExamArrange.action"><ext:button text="${app:i18n_menu_def('exaExamArrange.button.add.name', app:i18n('add'))}" var="btnAdd" handler="onAdd"/></app:isPermission>
					<app:isPermission code="/testarrange/editExaExamArrange.action"><ext:button text="${app:i18n_menu_def('exaExamArrange.button.edit.name', app:i18n('edit'))}" var="btnEdit" handler="onEdit"/></app:isPermission>
					<app:isPermission code="/testarrange/editExaExamArrange.action"><ext:button text="${app:i18n('testArrage.view')}" var="btnView" handler="onView"/></app:isPermission>
					<app:isPermission code="/testarrange/deleteExaExamArrange.action"><ext:button text="${app:i18n_menu_def('exaExamArrange.button.delete.name', app:i18n('delete'))}" var="btnDelete" handler="onDelete"/></app:isPermission>
					<app:isPermission code="/testarrange/deleteExaExamArrange.action"><ext:button text="${app:i18n('sendNotice')}" var="btnNotice" handler="onNotice"/></app:isPermission>
					<app:isPermission code="/testarrange/deleteExaExamArrange.action"><ext:button text="${app:i18n('querySendEamiStatus')}" var="btnQueryEmai" handler="onQueryEmail"/></app:isPermission>	
					<app:isPermission code="/testarrange/deleteExaExamArrange.action"><ext:button text="${app:i18n('batch.modify')}" var="btnbatch" handler="onBatch"/></app:isPermission>						
				    <ext:button text="${app:i18n_menu_def('qcsUser.button.reset.name', '查询条件重置')}" var="btnViewReset" handler="onResetQueryView"/>
				</ext:tbar>
				<ext:items>
					<ext:formPanel var="queryView" region="north" autoHeight="true" frame="true">
						<ext:items>
							<ext:fieldSet layout="column" title="${app:i18n('queryCondition')}">
								<ext:items>
									<ext:hidden name="query.id" var="query_id"></ext:hidden>
									<ext:hidden name="query.testpaperUrl" var="query_testpaperUrl"></ext:hidden>
									<ext:hidden name="query.createDept" var="queryCreateDept" ></ext:hidden>
									<ext:hidden name="query.examType" value="23" />
									<ext:panel width="250" layout="form">
										<ext:items>
											<ext:textField name="query.examNo" var="query_examNo" fieldLabel="${app:i18n('exaExamArrange.examNo')}" width="125"/>
										</ext:items>
									</ext:panel>
									<ext:panel width="0" layout="form">
										<ext:items>
											<ext:comboBox disabled="true" name="query.examType" var="query_examType" fieldLabel="${app:i18n('exaExamArrange.examType')}" width="125" hiddenName="query.examType" valueField="id" displayField="paramValue" triggerAction="all" editable="false" mode="remote" url="../sysparam/findByParamValue.action?paramValue.paramId=9" root="paramValues" listeners="{expand:initComboBox}"/>
										</ext:items>
									</ext:panel>
									<ext:panel width="250" layout="form" listeners="{afterlayout:onUIShow}">
										<ext:items>
										<ext:comboBox name="query.examName" var="query_examName" 
											fieldLabel="${app:i18n('exaExamArrange.examName')}" width="125" 
											hiddenName="query.examName" valueField="examName" displayField="examName" 
											triggerAction="all" editable="false" mode="remote" 
											url="../examnamemanage/findByExaExamNameManage.action" 
											root="exaExamNameManages" listeners="{expand:initComboBox}"/>
										</ext:items>
									</ext:panel>
									<ext:panel width="250" hidden="true" layout="form" >
										<ext:items>
										 <ext:comboBox var="exaExamRelative_groupId_to_show" mode="local"  valueField="groupId" hiddenName="groupId" displayField="groupName" width="190" readOnly="true" store="userGroupStore" />	
										</ext:items>
									</ext:panel>
								</ext:items>
							</ext:fieldSet>
						</ext:items>
					</ext:formPanel>
				 <!--树的目录-->
					<ext:gridPanel var="gridViewDir"  region="center"  frame="true" autoExpandColumn="grid_createDate"  >
						<ext:store var="gridStoreDir" url="../sysparam/findPageByParamValue.action" remoteSort="true">
							<ext:jsonReader totalProperty="totalSize" root="paramValues">
								<ext:fields type="com.sf.module.sysparam.domain.ParamValue"/>
							</ext:jsonReader>
						</ext:store>
						<ext:pagingToolbar var="pagingBar" pageSize="10" store="gridStoreDir" displayInfo="true"/>					
						<ext:checkboxSelectionModel/>
						<ext:columnModel>
							<ext:propertyColumnModel dataIndex="id" id="grid_id" header="${app:i18n('paramValue.id')}"/>
							<ext:propertyColumnModel dataIndex="paramId" id="grid_paramId" header="${app:i18n('paramValue.paramId')}"/>
							<ext:propertyColumnModel dataIndex="paramValue" id="grid_paramValue" header="${app:i18n('paramValue.paramValue')}"/>
							<ext:propertyColumnModel dataIndex="parentId" id="grid_parentId" header="${app:i18n('paramValue.parentId')}"/>
							<ext:propertyColumnModel dataIndex="describe" id="grid_describe" header="${app:i18n('paramValue.describe')}"/>
							<ext:propertyColumnModel dataIndex="creator" id="grid_creator" header="${app:i18n('paramValue.creator')}"/>
							<ext:propertyColumnModel dataIndex="createDate" id="grid_createDate" header="${app:i18n('paramValue.createDate')}" renderer="datetimeRenderer">
								<ext:dateField var="grid_createDate" format="Y-m-d H:i:s"/>
							</ext:propertyColumnModel>
						</ext:columnModel>
					</ext:gridPanel>
					<ext:gridPanel var="gridView" region="center" frame="true" autoExpandColumn="grid_examerNum" >
						<ext:store var="gridStore" url="findPageByExaExamArrange.action" remoteSort="true">
							<ext:jsonReader totalProperty="totalSize" root="exaExamArranges">
								<ext:fields type="com.sf.module.testarrange.domain.ExaExamArrange"/>
							</ext:jsonReader>
						</ext:store>
						<ext:pagingToolbar var="pagingBar" pageSize="20" store="gridStore" displayInfo="true"/>
						<ext:checkboxSelectionModel/>
						<ext:columnModel>
							
							<ext:propertyColumnModel dataIndex="op" id="grid_op" header="" renderer="showOperationDiv" width="30"/>
								
							<ext:propertyColumnModel dataIndex="id" id="grid_id" header="${app:i18n('exaExamArrange.id')}" hidden="true"/>
							<ext:propertyColumnModel dataIndex="examNo" id="grid_examNo" header="${app:i18n('exaExamArrange.examNo')}"/>
							<ext:propertyColumnModel dataIndex="examName" id="grid_examName" header="${app:i18n('exaExamArrange.examName')}"/>
							<ext:propertyColumnModel dataIndex="examType" id="grid_examType" header="${app:i18n('exaExamArrange.examType')}" renderer="comboboxRenderer"  hidden="true">
								<ext:comboBox var="grid_examType" valueField="id" displayField="paramValue" mode="local" store="examtype" root="paramValues"/>
							</ext:propertyColumnModel>
							
							<ext:propertyColumnModel dataIndex="testpaperUrl" id="grid_testpaperUrl" header="${app:i18n('exaExamArrange.testpaperUrl')}" hidden="true"/>
							<ext:propertyColumnModel dataIndex="testParamValue" id="grid_testParamValue" header="${app:i18n('exaExamArrange.testpaperUrl')}" />
							<ext:propertyColumnModel dataIndex="examBegin" id="grid_examBegin" header="考试开始时间" renderer="datetimeRenderer" sortable="true" >
								<ext:dateField var="grid_examBegin" format="Y-m-d H:i:s"/>
							</ext:propertyColumnModel>
							<ext:propertyColumnModel dataIndex="examEffectend" id="grid_examEffectend" header="考试结束时间" renderer="datetimeRenderer" sortable="true">
								<ext:dateField var="grid_examEffectend" format="Y-m-d H:i:s"/>
							</ext:propertyColumnModel>
							<ext:propertyColumnModel dataIndex="creator" id="grid_creator" header="${app:i18n('exaExamArrange.creator')}" />
							<ext:propertyColumnModel dataIndex="deptName" id="grid_deptName" header="${app:i18n('exaExamArrange.creator.deptName')}"/>
							<ext:propertyColumnModel dataIndex="createDept" id="grid_createDept" hidden="true"/>
							<ext:propertyColumnModel dataIndex="createDate" id="grid_createDate" header="${app:i18n('exaExamArrange.createDate')}" renderer="datetimeRenderer" sortable="true" >
								<ext:dateField var="grid_createDate" format="Y-m-d H:i:s"/>
							</ext:propertyColumnModel>
							<ext:propertyColumnModel header="${app:i18n('exam.operate')}" renderer="showOperate">
							</ext:propertyColumnModel>
							<!-- 操作 -->
							<ext:propertyColumnModel dataIndex="passScore" id="grid_passScore" header="${app:i18n('exaExamArrange.passScore')}" hidden="true"/>
							<ext:propertyColumnModel dataIndex="examLast" id="grid_examLast" header="${app:i18n('exaExamArrange.examLast')}" hidden="true"/>
							<ext:propertyColumnModel dataIndex="testpaperId" id="grid_testpaperId" header="${app:i18n('exaExamArrange.testpaperId')}" hidden="true"/>
							<ext:propertyColumnModel dataIndex="testpaperName" id="grid_testpaperName" header="${app:i18n('exaExamArrange.testpaperName')}" hidden="true"/>
							<ext:propertyColumnModel dataIndex="passcent" id="grid_passcent" header="${app:i18n('exaExamArrange.passcent')}" hidden="true"/>							
							<ext:propertyColumnModel dataIndex="examTime" id="grid_examTime" header="${app:i18n('exaExamArrange.examTime')}" hidden="true"/>
							<ext:propertyColumnModel dataIndex="comentDetail" id="grid_comentDetail" header="${app:i18n('exaExamArrange.comentDetail')}" hidden="true"/>
							<ext:propertyColumnModel dataIndex="examMode" id="grid_examMode" header="${app:i18n('exaExamArrange.examMode')}" hidden="true"/>						
							<ext:propertyColumnModel dataIndex="isOpen" id="grid_isOpen" header="${app:i18n('exaExamArrange.isOpen')}" hidden="true"/>
							<ext:propertyColumnModel dataIndex="isNeedcheck" id="grid_isNeedcheck" header="${app:i18n('exaExamArrange.isNeedcheck')}" hidden="true"/>
							<ext:propertyColumnModel dataIndex="autosaveSecond" id="grid_autosaveSecond" header="${app:i18n('exaExamArrange.autosaveSecond')}" hidden="true"/>
							<ext:propertyColumnModel dataIndex="isPublishAll" id="grid_isPublishAll" header="${app:i18n('exaExamArrange.isPublishAll')}" hidden="true"/>
							<ext:propertyColumnModel dataIndex="isAllowSee" id="grid_isAllowSee" header="${app:i18n('exaExamArrange.isAllowSee')}" hidden="true"/>
							<ext:propertyColumnModel dataIndex="examerNum" id="grid_examerNum" header="${app:i18n('exaExamArrange.examerNum')}" hidden="true"/>
						</ext:columnModel>
					</ext:gridPanel>
				</ext:items>
			</ext:panel>
		</ext:items>
	</ext:viewport>
	<ext:window var="editView" title="${app:i18n('testArrage.Info')} " closeAction="hide" width="700" height="535" layout="border" modal="true" frame="true" listeners="{beforeshow:showT,show:afterShowEditView}" >
		<ext:tbar>
			<ext:button text="数据校验" var="btnvalidation" handler="btnvalidation" />
			<app:isPermission code="/testarrange/saveExaExamArrange.action"><ext:button text="${app:i18n_menu_def('exaExamArrange.button.save.name', app:i18n('save'))}" var="btnSave" handler="onSave"/></app:isPermission>
		</ext:tbar>
		<ext:items>
		<ext:formPanel var="editForm"  layout="column" frame="true" region="center"  height="500" >
				<ext:submitAction name="saveExaExamArrange" url="saveExaExamArrange.action" success="showSaveSuccessInfo" failure="showSaveFailureInfo" waitMsg="${app:i18n('saving')}"/>
				<ext:items>
		<ext:tabPanel deferredRender="false"  var="tabs" region="center"  activeTab="0" width="670" defaults="{autoScroll:true}" autoScroll="true" enableTabScroll="true" height="480" border="0">
		<ext:items>
		   <ext:panel id="standarInfo" title="${app:i18n('testArrage.basicInfo')}"  frame="true">
			<ext:items>
					<ext:panel layout="form" autoHeight="true" >
						<ext:items>
						    <ext:panel html="&nbsp;"></ext:panel>
						    <ext:hidden var="min_Date" value='${minDate}'/>
						    <ext:hidden name="exaExamArrange.createDept" var="exaExamArrange_createDept"/>
							<ext:hidden  name="exaExamArrange.id" var="exaExamArrange_id" tabIndex="1" fieldLabel="${app:i18n('exaExamArrange.id')}<font color=red>*</font>" width="125" allowBlank="false" decimalPrecision="0" />
							<ext:hidden name="slaves" var="exaExamArrange_slaves"/>	
							<ext:textField name="exaExamArrange.examNo" var="exaExamArrange_examNo" tabIndex="2" fieldLabel="${app:i18n('exaExamArrange.examNo')}" width="225" minLength="0" maxLength="36"/>
							<ext:hidden name="exaExamArrange.examType" value="23"></ext:hidden>
							<ext:textField  var="exaExamArrange_examType" disabled="true" fieldLabel="${app:i18n('exaExamArrange.examType')}<font color=red>*</font>" width="225" value="考试" />
							<ext:comboBox   var="exaExamArrange_examName" 
											tabIndex="4" fieldLabel="${app:i18n('exaExamArrange.examName')}<font color=red>*</font>" 
											width="225"  maxLength="75" maxLengthText="最大值为75"
											valueField="examNameId" displayField="examName"
											triggerAction="all" editable="false" mode="remote" 
											url="../examnamemanage/findByExaExamNameManageOnCreate.action" 
											root="exaExamNameManages" listeners="{expand:initComboBox,select:makeSubmitValue}"/>
							<ext:panel   hidden="true" var="exaExamArrange_selfDef_examName_copy" layout="form" autoHeight="true">
								 <ext:items>
									  <ext:textField  var="exaExamArrange_selfDef_examName"  
										fieldLabel="自主考试名称<font color=red>*</font>" 
										width="225" />
								 </ext:items>
							</ext:panel>
							<ext:panel hidden="true" var="exaExamArrange_examName_submit_copy" layout="form" autoHeight="true">
								 <ext:items>
									<ext:textField name="exaExamArrange.examName" var="exaExamArrange_examName_submit"  
									fieldLabel="提交考试名称隐藏域<font color=red>*</font>" 
									width="225" />
								</ext:items>
							</ext:panel>
							<ext:panel hidden="true"  var="exaExamArrange_createDeptName_Copy" layout="form" autoHeight="true">
								 <ext:items>
									<ext:textField name="exaExamArrange.createDeptName" var="exaExamArrange_createDeptName_submit"  
									fieldLabel="部门名<font color=red>*</font>" 
									width="225" />
								</ext:items>
							</ext:panel>
							<ext:panel hidden="true" var="exaExamArrange_parentDeptCode_copy" layout="form" autoHeight="true">
								 <ext:items>
									<ext:textField name="exaExamArrange.parentDeptCode" var="exaExamArrange_parentDeptCode_submit"  
									fieldLabel="所属经营本部编号<font color=red>*</font>" 
									width="225" />
								</ext:items>
							</ext:panel>
							<ext:panel hidden="true" var="exaExamArrange_parentDeptName_copy" layout="form" autoHeight="true">
								 <ext:items>
									<ext:textField name="exaExamArrange.parentDeptName" var="exaExamArrange_parentDeptName_submit"  
									fieldLabel="所属经营本部名称<font color=red>*</font>" 
									width="225" />
								</ext:items>
							</ext:panel>
							<ext:hidden name="exaExamArrange.examNameId" var="exaExamArrange_examNameId"  ></ext:hidden>
							<ext:hidden name="exaExamArrange.selfNameRemarks" var="exaExamArrange_selfDefExamNameRemarks"></ext:hidden>
							
							<!-- ======================= -->
							<ext:panel layout="column">
							<ext:items>
							<ext:panel layout="form" width="150">
							<ext:items>
							<ext:numberField name="exaExamArrange.examLast" value="60"   var="exaExamArrange_examLast" tabIndex="6" fieldLabel="${app:i18n('exaExamArrange.examLast')}<font color=red>*</font>" width="40" allowBlank="false" decimalPrecision="0"/>
							</ext:items>
							</ext:panel>
							<ext:panel html="${app:i18n('testArrange.minute')}" width="40"></ext:panel>
							<ext:panel layout="form" width="20">
							<ext:items>							
							<ext:checkbox relateName="exaExamArrange_isNoLimitDate" trueValue="Y" falseValue="N"  tabIndex="6" hideLabel="true" fieldLabel="不计时" width="10" listeners="{check: checkboxClick}"   />
							<ext:hidden name="exaExamArrange.isNoLimitDate" value="N" var="exaExamArrange_isNoLimitDate"/>
							</ext:items>
							</ext:panel>
							<ext:panel html="${app:i18n('testArrange.noLimite')}" width="40"></ext:panel>
							</ext:items>
							</ext:panel>
							<ext:hidden name="exaExamArrange.testpaperId" var="exaExamArrange_testpaperId" tabIndex="7" fieldLabel="${app:i18n('exaExamArrange.testpaperId')}"   />
							<ext:hidden name="exaExamArrange.testpaperName" var="exaExamArrange_testpaperName" tabIndex="8" fieldLabel="${app:i18n('exaExamArrange.testpaperName')}" />	
							<ext:panel layout="column">
							<ext:items>
							<ext:panel layout="form" width="150">
							<ext:items>
							<ext:numberField name="exaExamArrange.examTime" var="exaExamArrange_examTime" value="1" tabIndex="12" fieldLabel="${app:i18n('exaExamArrange.examTime')}" width="40" decimalPrecision="0"/>
							</ext:items>
							</ext:panel>
							<ext:panel html="${app:i18n('testArrange.times')}" width="40"></ext:panel>
							<ext:panel layout="form" width="20">
							<ext:items>
							<ext:checkbox   relateName="exaExamArrange_isNoLimitTime"  tabIndex="6" hideLabel="true" fieldLabel="${app:i18n('testArrange.noLimitTime')}" trueValue="Y" falseValue="N" width="10" decimalPrecision="0" listeners="{check: checkboxClick}"/>
							<ext:hidden name="exaExamArrange.isNoLimitTime" value="N" var="exaExamArrange_isNoLimitTime"/>
							</ext:items>
							</ext:panel>
							<ext:panel html="${app:i18n('testArrange.noLimitTime')}" width="50"></ext:panel>
							</ext:items>
							</ext:panel>							
							<ext:panel layout="column" title="${app:i18n('testArrange.chooseItems')}" width="650">
							      <ext:items>
							      	<ext:panel layout="form" width="125">
							      		<ext:items>
							      			<ext:checkbox relateName="exaExamArrange_isOpen" hideLabel="true"  boxLabel="${app:i18n('testArrange.IsOpen')}" trueValue="Y" falseValue="N" listeners="{check: checkboxClick}"/>
							      		</ext:items>
							      	</ext:panel> 
							      	<ext:panel layout="form" width="125">
							      		<ext:items>
							      			<ext:checkbox relateName="exaExamArrange_isAllowSee" hideLabel="true"  boxLabel="${app:i18n('Arrange.IsAllowSee')}" trueValue="Y" falseValue="N" listeners="{check: checkboxClick}" />
							      		</ext:items>
							      	</ext:panel> 
							      	<ext:panel layout="form" width="125">
							      		<ext:items>
							      			<ext:hidden  relateName="exaExamArrange_isPublishAll" hideLabel="true"  boxLabel="${app:i18n('testArrange.IsOpenToAll')}" trueValue="Y" falseValue="N" listeners="{check: checkboxClick}" />
							      		</ext:items>
							      	</ext:panel>
							    </ext:items>
							</ext:panel>
							<ext:hidden name="exaExamArrange.testpaperUrl" var="exaExamArrange_testpaperUrl" tabIndex="15" fieldLabel="${app:i18n('exaExamArrange.testpaperUrl')}" width="225" decimalPrecision="0"/>
							<ext:textField name="exaExamArrange.testParamValue" var="exaExamArrange_testParamValue" tabIndex="15" fieldLabel="${app:i18n('exaExamArrange.testpaperUrl')}" width="225" decimalPrecision="0"/>
							<ext:textArea name="exaExamArrange.comentDetail" var="exaExamArrange_comentDetail" tabIndex="13" fieldLabel="${app:i18n('exaExamArrange.comentDetail')}" width="225" maxLength="600"/>
							<ext:hidden name="exaExamArrange.examMode" var="exaExamArrange_examMode" tabIndex="14" fieldLabel="${app:i18n('exaExamArrange.examMode')}" width="125"/>														
							<ext:hidden name="exaExamArrange.isOpen" value="N" var="exaExamArrange_isOpen" tabIndex="18" fieldLabel="${app:i18n('exaExamArrange.isOpen')}" width="125"/>
							<ext:hidden name="exaExamArrange.isNeedcheck" value="N" var="exaExamArrange_isNeedcheck" tabIndex="19" fieldLabel="${app:i18n('exaExamArrange.isNeedcheck')}" width="125"/>
							<ext:hidden name="exaExamArrange.autosaveSecond" value="10" var="exaExamArrange_autosaveSecond" tabIndex="20" fieldLabel="${app:i18n('exaExamArrange.autosaveSecond')}" width="125" decimalPrecision="0"/>
							<ext:hidden name="exaExamArrange.isPublishAll" value="N" var="exaExamArrange_isPublishAll" tabIndex="21" fieldLabel="${app:i18n('exaExamArrange.isPublishAll')}" width="125"/>
							<ext:hidden name="exaExamArrange.isAllowSee" value="N" var="exaExamArrange_isAllowSee" tabIndex="22" fieldLabel="${app:i18n('exaExamArrange.isAllowSee')}" width="125"/>
							<ext:hidden name="exaExamArrange.versions"  var="exaExamArrange_versions" tabIndex="23" fieldLabel="${app:i18n('exaExamArrange.versions')}" width="125" />
							<ext:hidden name="exaExamArrange.examerNum" var="exaExamArrange_examerNum" tabIndex="24" fieldLabel="${app:i18n('exaExamArrange.examerNum')}" width="125" decimalPrecision="0"/>
							<ext:panel layout="column">
							<ext:items>
							<ext:panel layout="form" width="270" var="ctp">
							<ext:items>
							<ext:dateField  readOnly="false"  name="exaExamArrange.createDate" var="exaExamArrange_createDate" tabIndex="11" fieldLabel="${app:i18n('exaExamArrange.createDate')}" width="155" format="Y-m-d H:i:s"/>
							</ext:items>
							</ext:panel>
							<ext:panel layout="form" width="270" var="ctp1">
							<ext:items>
							<ext:textField  disabled="true"  var="exaExamArrange_createDate1"  fieldLabel="${app:i18n('exaExamArrange.createDate')}" width="155" />
							</ext:items>
							</ext:panel>
							<ext:panel layout="form" width="220" var="ctr">
							<ext:items>
							<ext:textField readOnly="true" name="exaExamArrange.creator" var="exaExamArrange_creator" tabIndex="10" fieldLabel="${app:i18n('exaExamArrange.creator')}" width="105" />
							</ext:items>
							</ext:panel>
							</ext:items>
							</ext:panel>
							<ext:button  text="${app:i18n('testArrange.nextStept')}" handler="activeTab" location="1"></ext:button>
						</ext:items>
					</ext:panel>
			</ext:items>
			</ext:panel>
			<ext:panel   id="examInfo" title="${app:i18n('tesArrange.paperInfo')}" autoScroll="true" frame="true" >
			<ext:items>
					<ext:panel layout="form" >
						<ext:items>
						<ext:panel layout="form">
						<ext:items>
						<ext:hidden name="exaExamArrange.createMethod" var="save_createMethod" />
						<ext:hidden name="exaExamArrange.passcent" var="exaExamArrange_passcent" tabIndex="9" fieldLabel="${app:i18n('exaExamArrange.passcent')}" width="125" decimalPrecision="0"/>
						<ext:numberField name="exaExamArrange.passScore" value="60" var="exaExamArrange_passScore" tabIndex="5" fieldLabel="${app:i18n('exaExamArrange.passScore')}<font color=red>*</font>" width="125" decimalPrecision="0" allowBlank="false" />
						<ext:hidden name="exaExamArrange.isMixOrder" value="N" var="exaExamArrange_isMixOrder" width="125"/>
						<ext:checkbox relateName="exaExamArrange_isMixOrder" hideLabel="true"  boxLabel="${app:i18n('testArrange.isMixOrder')}" trueValue="Y" falseValue="N" listeners="{check: checkboxClick}"/>
						</ext:items>
						</ext:panel>
						<ext:panel layout="form" width="250">
						<ext:items>
						<ext:comboBox var="query_createMethod3"  fieldLabel="${app:i18n('testArrange.paperType')}<font color=red>*</font>" width="125" valueField="id" displayField="paramValue" triggerAction="all" editable="false" mode="local" store="createMethodStore" root="paramValues" listeners="{beforeselect:typechange,select:choosePaparMethod}" />
						</ext:items>
						</ext:panel>
						
						<ext:panel layout="form" html="<a href='javascript:choosePaperByDept()'>${app:i18n('testArrange.choosePaper')}</a>" width="220">
						
						</ext:panel>
						<ext:panel width="500">
						<ext:items>						
						<ext:gridPanel  width="480" autoHeight="true" var="selectedPaper" region="center" frame="true"   loadMask="true" >
						<ext:store var="paperStore" url="../testpapermagr/findPageByExaTestPaperInfo.action" remoteSort="true">
							<ext:jsonReader totalProperty="totalSize" root="exaTestPaperInfos">
								<ext:fields type="com.sf.module.testpapermagr.domain.ExaTestPaperInfo"/>
							</ext:jsonReader>
						</ext:store>						
						<ext:columnModel >
						<ext:propertyColumnModel dataIndex="testpaperName" id="grid_testpaperName" header="${app:i18n('exaExamArrange.testpaperName')}"/>	
							<ext:propertyColumnModel dataIndex="testPoolCount" id="grid_testPoolCount" header="试题数" width="70" />
							<ext:propertyColumnModel dataIndex="score" id="grid_score" header="${app:i18n('testArrange.totalScore')}" width="70" />
							<ext:propertyColumnModel dataIndex="creator" id="grid_creator" header="${app:i18n('paramValue.creator')}" width="70" />
							<ext:propertyColumnModel dataIndex="createTime" id="grid_createTime" header="${app:i18n('testArrange.createDate')}" width="150" renderer="datetimeRenderer">
								<ext:dateField var="grid_createTime"  width="140" format="Y-m-d H:i:s"/>
							</ext:propertyColumnModel>	
						</ext:columnModel>
					</ext:gridPanel>
						</ext:items>
						</ext:panel>						  
						    <ext:button text="${app:i18n('testArrange.upStept')}" handler="activeTab" location="0"></ext:button>
							<ext:button text="${app:i18n('testArrange.nextStept')}" handler="activeTab" location="2"></ext:button>							
						</ext:items>
					</ext:panel>
			</ext:items>
			</ext:panel>
			<ext:panel   id="arrangeInfo" title="${app:i18n('testArrage.Info')}" autoScroll="true" frame="true" height="500">
			<ext:items>
					<ext:panel layout="form" >
						<ext:items>
						<!--=========================example of add===============================  -->
						  <ext:panel title="${app:i18n('testArrang.StuArrange')}&nbsp;&nbsp;<a href='javascript:firstAddStu()'>${app:i18n('add')}${app:i18n('exaExamArrange')}</a>&nbsp;&nbsp;<font color=red>${app:i18n('cannotEditExamDate')}</font> ">
						  <ext:items>
						  <ext:panel var="c">
						  <ext:items>
						  <ext:panel layout="form" var="stu" id="0">
						  <ext:items>
						  <ext:panel html="${app:i18n('testArrage.Info')}" ></ext:panel>
						    <ext:dateField name="exaExamArrange.examBegin"   id="exaExamArrange_examBegin" var="exaExamArrange_examBegin" tabIndex="16" fieldLabel="${app:i18n('exaExamArrange.examBegin')}<font color=red>*</font>" width="225" format="Y-m-d H:i:s" allowBlank="false"  listeners="{change:DateChange,focus:focusFunction}"  />
							<ext:dateField name="exaExamArrange.examEffectend"  id="exaExamArrange_examEffectend" var="exaExamArrange_examEffectend" tabIndex="17" fieldLabel="${app:i18n('exaExamArrange.examEffectend')}<font color=red>*</font>" width="225" format="Y-m-d H:i:s" allowBlank="false" listeners="{change:DateChange,focus:focusFunction}" />
						  <ext:panel html="${app:i18n('testArrang.StuRange')}"></ext:panel>	
							<ext:editorGridPanel loadMask="true" autoScroll="true" autoHeight="true" var="exaExamRelativeGrid"  autoExpandColumn="exaExamRelative_id" region="center" frame="true" clicksToEdit="1"  id="com.sf.module.testarrange.domain.ExaExamRelative" listeners="{beforeedit: gridBeforeEdit, afteredit: gridAfterEdit}" maxHeight="300">
								<ext:tbar>
									<ext:button text="${app:i18n('delete')}" var="btnDeleteExaExamRelative" handler="firstOnDeleteExaExamRelative" location="0" />
									<ext:button text="${app:i18n('add')}" var="add" handler="firstShowuser" location="0"/>
								</ext:tbar>
								<ext:store remoteSort="false">
									<ext:jsonReader root="exaExamRelatives">
										<ext:fields type="com.sf.module.testarrange.domain.ExaExamRelative"/>
									</ext:jsonReader>
								</ext:store>
								<ext:rowSelectionModel/>
								<ext:columnModel>
									<ext:propertyColumnModel dataIndex="rn" width="40" renderer="initRowIndex" />
									<ext:propertyColumnModel dataIndex="examId" id="exaExamRelative_examId" header="${app:i18n('exaExamRelative.examId')}" hidden="true">
										<ext:numberField var="exaExamRelative_examId" decimalPrecision="0"  />
									</ext:propertyColumnModel>
									<ext:propertyColumnModel dataIndex="effectStart" id="exaExamRelative_effectStart" header="${app:i18n('exaExamRelative.effectStart')}" renderer="datetimeRenderer" hidden="true">
										<ext:dateField var="exaExamRelative_effectStart" format="Y-m-d H:i:s"/>
									</ext:propertyColumnModel>
									<ext:propertyColumnModel dataIndex="effectEnd" id="exaExamRelative_effectEnd" header="${app:i18n('exaExamRelative.effectEnd')}" renderer="datetimeRenderer" hidden="true">
										<ext:dateField var="exaExamRelative_effectEnd" format="Y-m-d H:i:s"/>
									</ext:propertyColumnModel>
									<ext:propertyColumnModel dataIndex="userName" id="exaExamRelative_userId" header="${app:i18n('exaExamRelative.userId')}">
										<ext:textField var="exaExamRelative_userId" decimalPrecision="0" readOnly="true"/>
									</ext:propertyColumnModel>
									<ext:propertyColumnModel dataIndex="userGroup" id="exaExamRelative_userGroup" header="${app:i18n('exaExamRelative.userGroup')}" hidden="true">
										<ext:numberField var="exaExamRelative_userGroup" decimalPrecision="0" readOnly="true" />
									</ext:propertyColumnModel>
									<ext:propertyColumnModel dataIndex="examTime" id="exaExamRelative_examTime" header="${app:i18n('exaExamRelative.examTime')}" hidden="true">
										<ext:numberField var="exaExamRelative_examTime" decimalPrecision="0"/>
									</ext:propertyColumnModel>
									<ext:propertyColumnModel dataIndex="judgeUser" id="exaExamRelative_judgeUser" header="${app:i18n('exaExamRelative.judgeUser')}" hidden="true">
										<ext:textField var="exaExamRelative_judgeUser"/>
									</ext:propertyColumnModel>
									<ext:propertyColumnModel dataIndex="userRealname" id="exaExamRelative_userRealname" header="${app:i18n('chooseUser.userrealname')}"width="200"  >
										<ext:textField var="exaExamRelative_userRealname" width="190" readOnly="true"/>
									</ext:propertyColumnModel>
									<ext:propertyColumnModel dataIndex="id" id="exaExamRelative_id" header="${app:i18n('exaExamRelative.id')}" hidden="true"/>
									<ext:propertyColumnModel dataIndex="groupId" id="exaExamRelative_groupId" renderer="renderGroupName" header="组别名称">
									   
									</ext:propertyColumnModel>
								</ext:columnModel>
							</ext:editorGridPanel>
						  </ext:items>
						  </ext:panel>
						  </ext:items>
						  </ext:panel>
						  </ext:items>
						  </ext:panel>
						    <ext:button text="${app:i18n('testArrange.upStept')}" handler="activeTab"  location="1"></ext:button>
						</ext:items>
					</ext:panel>
			</ext:items>
			</ext:panel>
			</ext:items>
			</ext:tabPanel>
			</ext:items>
			</ext:formPanel>
		</ext:items>
	</ext:window>
	<!--试卷选择窗口-->
		<ext:window var="paperView" title="${app:i18n('testArange.ChoosePaper')}" closeAction="hide" width="800" height="450" layout="border" modal="true" frame="true">
		<ext:items>
			<ext:panel region="west"  frame="false" autoScroll="true" width="210">
				<ext:items>
					 <ext:treePanel var="userTree2"  frame="false"  autoScroll="true" height="225" width="190">
						 <ext:treeLoader var="userPaperTreeLoader"  clearOnLoad="true" url="../sysparam/findDeptTree.action" idField="deptCode" textField="deptName" handler="selectPaperDept" listeners="{beforeload:KK}" />
						<ext:asyncTreeNode text="总部" id="001" listeners="{click:paperRootselected2}"/>
			  		 </ext:treePanel>
	            	 <ext:treePanel region="west" autoScroll="true" height="225" width="190">
						<ext:treeLoader var="testPaperTree" clearOnLoad="true" url="../sysparam/paramValueTreeByDataRole.action?paramid=12" idField="id" textField="paramValue" handler="onSelectNodePaper" listeners="{beforeload:setPaperParams}"/>
						<ext:asyncTreeNode var="testPaperTreeNode" text="${app:i18n('testArrange.paperUrl')}" id="12" listeners="{click:rootselected1}" />
					</ext:treePanel>
				</ext:items>
			</ext:panel>
			<ext:panel region="center" layout="border" frame="true">
				<ext:tbar>  
					<ext:button text="${app:i18n('search')}" var="btnSearchPaper" handler="onSearchPaper"/>
					<ext:button text="${app:i18n('choose')}" var="btnSelectPaper" handler="onSelectPaper"/>
					<ext:button text="重置" var="btnSelectReset" handler="onPaperReset"/>
				</ext:tbar>
				<ext:items>
					<ext:formPanel var="paperQueryView" region="north" autoHeight="true" frame="true">
						<ext:items>
							<ext:fieldSet layout="column" title="${app:i18n('queryCondition')}">
								<ext:items>
									<ext:hidden name="query.testpaperUrl" var="query_testpaperUrl2" ></ext:hidden>
									<ext:hidden name="query.createDept" var="queryPaperCreateDept" ></ext:hidden>
									<ext:hidden name="query.createMethod" var="query_finalMethod" ></ext:hidden>
									<ext:hidden name="query.status" value="25" ></ext:hidden>
									<ext:panel width="250" layout="form">
										<ext:items>
											<ext:comboBox disabled="true"  var="query_createMethod2" hiddenName="query.createMethod" fieldLabel="${app:i18n('testArrange.paperType')}" width="125" valueField="id" displayField="paramValue" triggerAction="all" editable="false" readOnly="true" mode="local" store="createMethodStore" root="paramValues"/>
										</ext:items>
									</ext:panel>
									<ext:panel width="250" layout="form">
										<ext:items>
											<ext:textField name="query.testpaperNo" var="query_paper_testpaperNo" fieldLabel="${app:i18n('exaTestPaperInfo.testpaperNo')}" width="125" decimalPrecision="0"/>
										</ext:items>
									</ext:panel>
									<ext:panel width="250" layout="form">
										<ext:items>
											<ext:textField name="query.testpaperName" var="query_paper_testpaperName" fieldLabel="${app:i18n('exaTestPaperInfo.testpaperName')}" width="125"/>
										</ext:items>
									</ext:panel>
									<ext:panel width="250" layout="form">
										<ext:items>
											<ext:comboBox name="query.testpaperDifficulty" var="query_paper_testpaperDifficulty" fieldLabel="${app:i18n('testPool.difficulty')}" width="125" hiddenName="query.testpaperDifficulty" valueField="paramValue" displayField="paramValue" triggerAction="all" editable="false" mode="remote" url="../sysparam/findByParamValue.action?paramValue.paramId=7" root="paramValues" listeners="{expand:initComboBox}"/>
										</ext:items>
									</ext:panel>								
								</ext:items>
							</ext:fieldSet>
						</ext:items>
					</ext:formPanel>
										
					<ext:gridPanel loadMask="true" var="paperGridView" region="center" frame="true" autoExpandColumn="grid_testPoolCount" listeners="{rowdblclick:onSelectPaper}">
						<ext:store var="paperGridStore" url="../testpapermagr/findPageByExaTestPaperInfo.action" remoteSort="true">
							<ext:jsonReader totalProperty="totalSize" root="exaTestPaperInfos">
								<ext:fields type="com.sf.module.testpapermagr.domain.ExaTestPaperInfo"/>
							</ext:jsonReader>
						</ext:store>
						<ext:pagingToolbar var="paperPagingBar" pageSize="20" store="paperGridStore" displayInfo="true"/>
						
							<ext:columnModel>
							<ext:propertyColumnModel dataIndex="testpaperNo" id="grid_testpaperNo" header="${app:i18n('exaTestPaperInfo.testpaperNo')}"/>
							
							<ext:propertyColumnModel dataIndex="testpaperUrl" id="grid_testpaperUrl2" header="分类" renderer="comboboxRenderer">
								<ext:comboBox var="grid_testpaperUrl2" valueField="id" displayField="paramValue" mode="local" store="paperStore_1" root="paramValues"/>
							</ext:propertyColumnModel>

							<ext:propertyColumnModel dataIndex="testpaperName" id="grid_testpaperName" header="${app:i18n('exaTestPaperInfo.testpaperName')}"/>
							<ext:propertyColumnModel dataIndex="score" id="grid_score" header="${app:i18n('exaTestPaperInfo.score')}"/>
							
							<ext:propertyColumnModel dataIndex="createTime" id="grid_createTime" header="${app:i18n('paramValue.createDate')}" renderer="datetimeRenderer">
								<ext:dateField var="grid_createTime" format="Y-m-d H:i:s"/>
							</ext:propertyColumnModel>
							<ext:propertyColumnModel dataIndex="testPoolCount" id="grid_testPoolCount" header="${app:i18n('testpool.testpooCount')}"/>
						</ext:columnModel>
					</ext:gridPanel>
				</ext:items>
			</ext:panel>				
		</ext:items>
	</ext:window>
	<!--目录选择窗口-->
		<ext:window var="dirView" title="选择考试目录" closeAction="hide" width="500" height="400" layout="border" modal="true" frame="true" listeners="{beforeshow:resetTree}">
		<ext:bbar>
			<ext:button text="${app:i18n('paramValue.addDir')}" var="confirm" handler="btnconfirm"></ext:button>
			<ext:button text="${app:i18n('canel')}" var="cancel" handler="btncancel"/>
		</ext:bbar>
		<ext:items>			
			<ext:treePanel var="tmp_load" region="center" autoScroll="true" autoWidth="true">
				<ext:treeLoader var="asdf" clearOnLoad="true" url="../sysparam/paramValueTree.action?paramid=13" idField="id" textField="paramValue" handler="onSelectNode2" listeners="{beforeload:setDeptParams}"/>
				<ext:asyncTreeNode text="考试安排" id="45" listeners="{click:rootselected}"/>
			</ext:treePanel>	 
		</ext:items>
	</ext:window>
	<!--选择用户-->
<ext:window var="choosUserView" title="选择用户" closeAction="hide" width="930" height="500" layout="border" modal="true" frame="true">
	<ext:items>	
		<ext:panel region="west"  frame="false" autoScroll="true" width="210">
				<ext:items>
					<ext:treePanel var="userTree"  frame="false"  autoScroll="true" height="260" width="190">
								 <ext:treeLoader clearOnLoad="true" url="../sysparam/findByUserDept.action" idField="deptCode" textField="deptName" handler="selectDept" listeners="{beforeload:KK}" />
								<ext:asyncTreeNode text="总部" id="001" listeners="{click:rootGroupSelected2}"/>
					</ext:treePanel>
					<ext:treePanel var="disGrouptree" collapsible="true" height="260"   autoScroll="true" width="190">
						<ext:treeLoader var="disGrouptreeLoader" url="../exagroup/groupTree.action"
							idField="groupId"  textField="groupName"  handler="onSelectGroup" listeners="{beforeload:setGroupParams}"/>
							
						<ext:asyncTreeNode var="disGrouptreeLoaderNode" text="自定义组" id="0" listeners="{click:setTestpaperUrl}"/>
						
						
					</ext:treePanel>
				</ext:items>
		</ext:panel>
			<ext:panel region="center" layout="border" frame="true">
		<ext:tbar>
			<ext:button text="${app:i18n('search')}" var="queryUserBut" handler="queryUserHdl"/>
			<ext:button text="${app:i18n('reset')}" var="btnUserRest" handler="onUserRest"/> 
			<ext:button text="${app:i18n('testArrange.confirm')}" var="btnUserConfirm" handler="onUserConfirm"/> 
		</ext:tbar>
		<ext:items>
					<ext:formPanel var="userQueryForm" region="north" height="100" frame="true">
						<ext:items>
							<ext:fieldSet layout="column" title="${app:i18n('queryCondition')}">
								<ext:items>
									<ext:panel var="user_time_panel" layout="form" width="430">
									  	<ext:items>
									  		<ext:dateField   var="user_BeginTime"    format="Y-m-d H:i:s"/>
									  		<ext:dateField   var="user_EndTime"  format="Y-m-d H:i:s"/>
									  	</ext:items>			
									  </ext:panel>
									<ext:panel width="300" layout="form">
										<ext:items>
											<ext:textField fieldLabel="${app:i18n('chooseUser.userid')}" name="query.empCode" var="empCodeVar"/>
										</ext:items>
									</ext:panel>
									<ext:panel width="300" layout="form">
										<ext:items>
											<ext:hidden var="tmp_location" />
											<ext:hidden var="arrange_Group" />
											<ext:hidden name="deptId" var="deptIdVar"/>
											<ext:textField fieldLabel="${app:i18n('chooseUser.userrealname')}" name="query.empName" var="usernameVar"/>
										</ext:items>
									</ext:panel>
									<ext:panel width="300" layout="form">
										<ext:items>
											<ext:textField fieldLabel="${app:i18n('chooseUser.userdeptcode')}"  var="deptCodeVar2" disabled="true"/>
											<ext:hidden name="query.deptCode" var="saveDeptCodeVar2" />
											
										</ext:items>
									</ext:panel>
								</ext:items>
							</ext:fieldSet>
						</ext:items>
					</ext:formPanel>
					<ext:panel var = "mainView" region="center" layout="column">
						<ext:items>
							<ext:panel  region="west"  width="310">
								<ext:items>
									<ext:formPanel  var="userFormPanel2" layout="column" title="${app:i18n('tactics.testPointchoosed')}"  width="297" >
										<ext:items>
											<ext:gridPanel var="userListGrid" frame="false" border="true" loadMask="true"  width="297" height="290">
												<ext:store  var='userStore' url="../exagroupuser/findPageByExaGroupUser1.action" remoteSort="true">
													<ext:jsonReader totalProperty="totalSize" root="exaGroupUsers">
														<ext:fields type="com.sf.module.exagroupuser.domain.ExaGroupUser"/>
													</ext:jsonReader>
												</ext:store>
												<ext:pagingToolbar var="pagingBars" pageSize="1000" autoWidth="true" store="userStore" displayInfo="true"/>	
												<ext:selectionAction name="saveUserForRole" url="updateUsers.action" success="function(){Ext.Msg.alert('Success', 'Save Users Success!');}"/>
												<ext:checkboxSelectionModel var="userList1"/>
												<ext:columnModel>
													<ext:propertyColumnModel dataIndex="userId"      hidden="true" />
													<ext:propertyColumnModel dataIndex="username"    hidden="true"   />
													<ext:propertyColumnModel dataIndex="empId"      hidden="true"/>
													<ext:propertyColumnModel dataIndex="empCode"    header="${app:i18n('chooseUser.userid')}"  />
													<ext:propertyColumnModel dataIndex="empName"    header="${app:i18n('chooseUser.userrealname')}"  />
													<ext:propertyColumnModel dataIndex="deptId"     hidden="true" />
													<ext:propertyColumnModel dataIndex="deptName"   header="${app:i18n('chooseUser.deptName')}"  />
													<ext:propertyColumnModel dataIndex="deptCode"   hidden="true" />																	
													<ext:propertyColumnModel dataIndex="userEmail"  hidden="true" />
													<ext:propertyColumnModel dataIndex="groupId"  header="组别ID" />	
													<ext:propertyColumnModel dataIndex="groupName"   header="组别名称"  />		
												</ext:columnModel>
											</ext:gridPanel>
										</ext:items>
									</ext:formPanel>
								</ext:items>
							</ext:panel>
							<ext:panel border="false" frame="false" height="300" width="75" layout="border">
								<ext:items>
								<ext:panel html="" region="west" width="25" border="false" frame="false">
								</ext:panel>
								<ext:panel html="" region="north" height="55" border="false" frame="false">
							</ext:panel>
							<ext:panel region="center" border="false" frame="false" layout="form">
									<ext:items>
										<ext:panel  html="" height="80" border="false"></ext:panel>
										<ext:panel  height="30" border="false" >
											<ext:items>
												<ext:button text=">>" tooltip="${app:i18n('packingup_tip')}" handler="selectedRows"  ></ext:button>
											</ext:items>
										</ext:panel>								
										<ext:panel  height="30" border="false" >
											<ext:items>
												<ext:button text="<&lt;" tooltip="${app:i18n('packingselect_tip')}" handler="delRows"  ></ext:button>
											</ext:items>
										</ext:panel>	
									</ext:items>
							</ext:panel>
							</ext:items>
							</ext:panel>
							<ext:panel  region="east" autoWidth="true" title="${app:i18n('tactics.testPointforchoose')}" height="300">
								<ext:items>										
											<ext:gridPanel loadMask="true"  var="userListGrid2" region="center" frame="false" border="true" width="295" height="290">
												 <ext:store   url="../exagroupuser/findPageByExaGroupUser1.action" remoteSort="true">
													<ext:jsonReader totalProperty="totalSize" root="exaGroupUsers">
														<ext:fields type="com.sf.module.exagroupuser.domain.ExaGroupUser"/>
													</ext:jsonReader>
												</ext:store>	
												<ext:selectionAction name="saveUserForRole" url="updateUsers.action" success="function(){Ext.Msg.alert('Success', 'Save Users Success!');}"/>
												<ext:checkboxSelectionModel var="userList1"/>
												<ext:columnModel>
													<ext:propertyColumnModel dataIndex="userId"      hidden="true" />
													<ext:propertyColumnModel dataIndex="username"   hidden="true" />
													<ext:propertyColumnModel dataIndex="empId"      hidden="true"/>
													<ext:propertyColumnModel dataIndex="empCode"    header="${app:i18n('chooseUser.userid')}"  />
													<ext:propertyColumnModel dataIndex="empName"    header="${app:i18n('chooseUser.userrealname')}"  />
													<ext:propertyColumnModel dataIndex="deptId"     header="${app:i18n('queryUserbyDeptCode.deptId')}" hidden="true" />
													<ext:propertyColumnModel dataIndex="deptName"   header="${app:i18n('chooseUser.deptName')}"  />
													<ext:propertyColumnModel dataIndex="deptCode"   header="${app:i18n('queryUserbyDeptCode.deptCode')}" hidden="true" />																	
													<ext:propertyColumnModel dataIndex="userEmail"   header="${app:i18n('queryUserbyDeptCode.deptCode')}" hidden="true" />	
													<ext:propertyColumnModel dataIndex="groupId"  header="组别ID" />	
													<ext:propertyColumnModel dataIndex="groupName"   header="组别名称"  />	
												</ext:columnModel>
											</ext:gridPanel>		
								</ext:items>
							</ext:panel>		
						</ext:items>
			</ext:panel>				 
		</ext:items>
	</ext:panel>
	</ext:items>	
</ext:window> 
	<!--目录编辑树窗口--> 	
	<ext:window var="editViewDir" title="${app:i18n('exaExamArrange')}" closeAction="hide" width="450" height="330" layout="border" modal="true" frame="true" listeners="{beforehide:hideT}">
		<ext:tbar>
			<app:isPermission code="/sysparam/saveParamValue.action"><ext:button text="${app:i18n_menu_def('paramValue.button.save.name', app:i18n('save'))}" var="btnSave1" handler="onSaveDir"/></app:isPermission>
			<ext:button text="${app:i18n_menu_def('paramValue.button.reset.name', app:i18n('reset'))}" var="btnReset" handler="onResetDir"/>
		</ext:tbar>
		<ext:items>
			<ext:formPanel var="editFormDir" region="center" layout="column" frame="true">
				<ext:submitAction name="saveParamValue" url="../sysparam/saveParamValue.action" success="showSaveSuccessInfoDir" failure="showSaveFailureInfo" waitMsg="${app:i18n('saving')}"/>
				<ext:items>
					<ext:panel layout="column">
						<ext:items>
							<ext:hidden name="paramValue.id" var="paramValue_id"/>						 	
							<ext:hidden name="paramValue.paramId" var="paramValue_paramId" tabIndex="1"   value="13"  />
							<ext:panel width="480" layout="form" listeners="{afterlayout:onUIShow}">
								<ext:items>
									<ext:textField name="paramValue.paramValue" var="paramValue_paramValue" tabIndex="2" fieldLabel="${app:i18n('paramValue.paramValue')}<font color=red>*</font>" width="170" allowBlank="false" maxLength="125" />
								</ext:items>
							</ext:panel>														
						  <ext:panel layout="form" width="240">
						  	<ext:items>
						  		<ext:comboBox hiddenName="paramValue.parentId" var="paramValue_parentId" readOnly="true" fieldLabel="${app:i18n('paramValue.parentId')}" width="125" hiddenName="paramValue.parentId" valueField="id"  displayField="paramValue" triggerAction="all"  mode="local" store="ds"  root="paramValues"  decimalPrecision="0" />	
						  	</ext:items>			
						  </ext:panel>
						  <ext:panel layout="form" width="240">
						  	<ext:html>
						  		<a href="#"><img src="../pages/sysparam/images/select.gif" onclick="editdirView()"  /></a>
						  	</ext:html>						  			
						  </ext:panel>
						  <ext:panel layout="form" width="430">
						  	<ext:items>
						  		<ext:textArea name="paramValue.describe" maxLength="300" var="paramValue_describe" tabIndex="4" fieldLabel="${app:i18n('paramValue.describe')}" width="250"></ext:textArea>
						  	</ext:items>			
						  </ext:panel>
						 <ext:panel layout="form" width="430">
						  	<ext:items>
						  		<ext:textArea name="paramValue.describe" var="paramValue_describe" tabIndex="4" fieldLabel="${app:i18n('paramValue.describe')}" width="250" height="90"></ext:textArea>
						  	</ext:items>			
						  </ext:panel>
						  <ext:panel var="dir_creator" layout="form" width="430">
						  	<ext:items>
						  		<ext:textField name="paramValue.creator" var="paramValue_creator"  fieldLabel="${app:i18n('paramValue.creator')} " width="170"  readOnly="true"/>
						  	</ext:items>			
						  </ext:panel>
						  <ext:panel var="dir_DateForShow" layout="form"  width="430">
						        <ext:items>
						            <ext:textField var="DateForShow" width="170"  fieldLabel="${app:i18n('paramValue.createDate')}" readOnly="true"  />
						        </ext:items>
						  </ext:panel>
						  		<ext:hidden   width="150" name="paramValue.createDate" var="paramValue_createDate" tabIndex="6" fieldLabel="${app:i18n('paramValue.createDate')} "  readOnly="true"   format="Y-m-d H:i:s"/>										
						</ext:items>
					</ext:panel>
				</ext:items>
			</ext:formPanel>
		</ext:items>
	</ext:window>
	<!-- 通知面板 -->
		<ext:window var="noticeView" title="${app:i18n('sendNotice')}" closeAction="hide" width="650" height="240" layout="border" modal="true" frame="true">
			<ext:tbar>
				<app:isPermission code="/testpool/addTestPool.action"><ext:button text="${app:i18n('send')}" var="btnSaveNotice" handler="onSaveNotice"/></app:isPermission>		 
			</ext:tbar>
		<ext:items>
			<ext:formPanel var="noticeForm" region="center" layout="column" frame="true">				 
				<ext:submitAction name="saveExamNotice" waitMsg="${app:i18n('issending')}" url="../testarrange/saveExaExamNotice.action" success="noticeSuccess" failure="showNoticeFalure" />
				<ext:items> 				 
					<ext:hidden name="exaExamNotice.examids" var="exam_ids" ></ext:hidden>
					<ext:hidden name="exaExamNotice.examNames" var="exam_names"></ext:hidden>
					<ext:hidden name="exaExamNotice.noticetype"  value="${app:i18n('exaExamNotice')}"></ext:hidden>
					<ext:panel title="${app:i18n('exaExamNotice.isSent')}" layout="form" width="80" frame="false" border="0">
						 <ext:items>				
						 	<ext:hidden name="useNotice" var="useNotice_1"  />
						 	<ext:checkbox relateName="useNotice_1" inputValue="Y" hideLabel="true"   boxLabel="${app:i18n('notice.sysNotice')}" trueValue="Y" falseValue="N" listeners="{check: checkboxClick}" />
						 	<ext:checkbox relateName="useEmial_1" inputValue="Y"  hideLabel="true"   boxLabel="${app:i18n('notice.email')}" trueValue="Y" falseValue="N" listeners="{check: checkboxClick}" />
						 	<ext:hidden name="useEmial" var="useEmial_1"  />	
						</ext:items>
					</ext:panel>
					<ext:panel title="${app:i18n('notice.modelTitle')}" layout="form" width="195" frame="false" border="0">
						 <ext:items>
						 	<ext:textArea name="exaExamNotice.noticeTitle"  var="notice_title" hideLabel="true" width="194" value="${app:i18n('notice.modelTitleBorder')}" maxLength="250"/>
						</ext:items> 
					</ext:panel>
					<ext:panel title="${app:i18n('notice.modelContent')}" layout="form" width="340" frame="false" border="0">
						  <ext:items>
						 	<ext:textArea name="exaExamNotice.comments" var="notice_content" hideLabel="true" width="335" value="${app:i18n('notice.modelContentBorder')}" maxLength="1000"/>
						</ext:items>
					</ext:panel>
					<ext:panel title="${app:i18n('notice.sendDate')}" var="noticeDates" layout="form" width="145" frame="false" border="0">
						  <ext:items>
						 	<ext:dateField name="exaExamNotice.effectEnd"  var="notice_date" hideLabel="true" width="145"  format="Y-m-d H:i:s"/>
						</ext:items>
					</ext:panel>	
				</ext:items>
			</ext:formPanel>
		</ext:items>
	</ext:window>
	<!--批量修改-->
<ext:window var="batchModify" title="${app:i18n('batch')}" closeAction="hide" width="600" height="500" layout="border" modal="true" frame="true" autoScroll="true">
		<ext:tbar>
			<ext:button text="${app:i18n('save')}" var="btnReset3" handler="batchsave"/>	
			<ext:button text="${app:i18n_menu_def('exaExamArrange.button.reset.name', app:i18n('reset'))}" var="btnReset1" handler="onReset"/>
			<ext:html><font color=red>${app:i18n('batch.Info')}</font></ext:html>
		</ext:tbar>
		<ext:items>
			<ext:formPanel labelWidth="100" var="batchfrom" region="center" layout="column" frame="true" border="0" autoHeight="true"  >
				<ext:submitAction name="batchModify" url="../testarrange/batchModify.action" success="showSaveSuccessInfoBatch" failure="showSaveFailureInfo" waitMsg="${app:i18n('saving')}"/>
				 <ext:items>	 
					<ext:hidden name="batch.batchids" var="batch_ids"/>
					<ext:hidden name="batch.id" var="batch_id"/>
					<ext:hidden name="batch.slaves" var="batch_slaves"/>								 
					<ext:panel layout="column" width="600"   >
						<ext:items>
							<ext:panel layout="form" width="420">
								<ext:items>
								  	<ext:comboBox hiddenName="batch.testpaperUrl"  var="batch_testpaperUrl" readOnly="true" 
								  	fieldLabel="${app:i18n('batch.url')}" width="300"  valueField="id"  displayField="paramValue" 
								  	triggerAction="all"  mode="local" store="ds1"  root="paramValues"  />	
								</ext:items>			
							</ext:panel>
							<ext:panel layout="form" width="150">
								  <ext:html>
								  		<a href="#"><img src="../pages/sysparam/images/select.gif" onclick="editdirView()"  /></a>
								  </ext:html>						  			
							</ext:panel>	
						</ext:items>
					</ext:panel>				 
					<ext:panel layout="form" width="550">
						<ext:items>
							 <ext:numberField name="batch.examTime" var="batch_examTime"  fieldLabel="${app:i18n('exaExamArrange.examTime')}" width="125" decimalPrecision="0"/>
						</ext:items>
					</ext:panel>
				</ext:items>
			</ext:formPanel>
		</ext:items>
	</ext:window>		
	<ext:script>
		var deptCodeTreeSelect='001';
		//hideButton(deptCodeTreeSelect);
		if('${deptCode}'!='001'){
			
	        btnAdd.hide();
			btnEdit.hide() ;
			btnDelete.hide();
			btnbatch.hide();
			btnView.show();
			btnNotice.hide();
			btnAddDir.hide();
			btnEditDir.hide();
			btnDeleteDir.hide();
        }else{
        	btnView.hide();
        	
        	//deptCodeTreeSelect='${deptCode}';
        	
        }
        queryCreateDept.setValue(deptCodeTreeSelect);
		//提前加载
		//gridView.getStore().on("beforeload",function(){grid_testpaperUrl.store.load();});
		gridView.getStore().baseParams["query.examType"] = "23";
		//grid_testpaperUrl.store.on("load",function(){gridView.getStore().load();	});
		noticeDates.hide();
		user_time_panel.hide();
		//grid_testpaperUrl.getStore().load();
		//面板的数目 当做gecmp的ID
		var stuIndex=0;
		// 用来判断是新增或者是修改
		var isAddOrEdit=0;
		
		function firstShowuser(o){
			if(deptCodeTreeSelect=='${deptCode}'){			
				showuser(o);
			}
		}
		function showuser(o)
		{	
			//userQueryForm.getForm().reset();
			arrange_Group.setValue(o.location);
			tmp_location.setValue(o.location);
		    userListGrid.getStore().removeAll();
			userListGrid2.getStore().removeAll();   			  	 
			if(o.location==0)
			{
				if(exaExamArrange_examBegin.getValue()==''||exaExamArrange_examEffectend.getValue()=='')
				{
				 Ext.Msg.alert('提示','请先确定考试的时间范围');
				}
				else
				{
				 if(exaExamArrange_examBegin.getValue()>=exaExamArrange_examEffectend.getValue())
				 {
				 	Ext.Msg.alert('提示','结束时间必须大于开始时间');
				 }
				 else
				 {	
				 user_BeginTime.setValue(exaExamArrange_examBegin.getValue());
				 user_EndTime.setValue(exaExamArrange_examEffectend.getValue());
				 choosUserView.show();
				 }
				}
			}
			if(o.location!=0)
			{	var tmp_begin = "begintime"+o.location;
				var tmp_end  =  "endtime"+o.location;
				var tmp_begin1 = Ext.getCmp(tmp_begin).getValue();
				var tmp_end1 = Ext.getCmp(tmp_end).getValue()
		   		if(tmp_begin1==''||tmp_end1=='')
		   		{
		   		 	Ext.Msg.alert('提示','请先确定考试的时间范围');
		   		}
		   		else
		   		{
		   			if (tmp_begin1>=tmp_end1) 
		   			{
		   				Ext.Msg.alert('提示','结束时间必须大于开始时间');
		   			}
		   			else
		   			{
			   		 user_BeginTime.setValue(tmp_begin1);
					 user_EndTime.setValue(tmp_end1);
					 choosUserView.show();
		   			}
		   		}		  
			}
			userQueryForm.getForm().reset();
		} 
		var wintmp = 0 ;
		function showuser2(o)
		{	 
			wintmp = 1;
			//先清空再添加
			choosUserView.show();
			userListGrid.getStore().removeAll();
			userListGrid2.getStore().removeAll();
		}
		gridViewDir.hide();
		// gridView.hide();
		var tmpchidnode ='';
		var treetmp = null;
		
		//目录编辑窗口打开
		function editdirView()
		{
			dirView.show();
		}
		
		function onSelectNode2(node)
		{
		  treetmp = node.id; 
		  batch_testpaperUrl.setValue(node.id);
		  
		}
		var tmpqueryid=null;
		
		function rootselected()
		{	   	 
		 treetmp =45;
		  query_id.setValue(0);
		  tmpqueryid=query_id.getValue();
		  onSearchDir();	  
		  paramValue_parentId.setValue(0);
		  queryView.getForm().reset();		   			  	  
		  onSearch();
		}	
		function onSelectNode(node) {
				query_id.setValue(node.id);
				tmpqueryid=query_id.getValue();
				tmpchidnode = node.childNodes;		      
			    paramValue_parentId.setValue(node.id);		     	    
				onSearchDir();	
				query_testpaperUrl.setValue(node.id);		
				onSearch();
		}		
		//目录增加
		function btnAddDir()
		{   
		   var selNode = distree.getSelectionModel().getSelectedNode();
			if(!selNode) {
				Ext.Msg.alert('${app:i18n('prompt')}', '${app:i18n('chooseUpperFload')}');
				return;
			}
		  
			setTitle(btnAdd.text);
			isNewRecord = true;
			//editFormDir.getForm().reset();
			paramValue_id.setValue(null);//把id设置为sequence的下一个就对了。为null时候就可以了.
			setEditable(editView, true);			
			editViewDir.show();
			editFormDir.getForm().reset();	 
			paramValue_parentId.disable();
			dir_creator.hide();
			dir_DateForShow.hide();
			gridViewDir.getSelectionModel().selectAll();
			record = gridViewDir.getSelectionModel().getSelections()[0];
		    paramValue_parentId.setValue(selNode.id);							 		
		}
		//目录编辑
		function btnEditDir()
		{
		   	var selNode = distree.getSelectionModel().getSelectedNode();
			if(!selNode) {
				Ext.Msg.alert("错误","请选择要编辑的节点！");
				return;
			}
			if (tmpqueryid==null||tmpqueryid=="") {
				Ext.MessageBox.alert('${app:i18n('prompt')}','${app:i18n('selectOneRecord')}');
				return;
			}else if(tmpqueryid==0){
			  Ext.MessageBox.alert('${app:i18n('prompt')}','根节点不能编辑');
			  return;
			}
			gridViewDir.getSelectionModel().selectAll();
			record = gridViewDir.getSelectionModel().getSelections()[0];
			
			var tmp = record.data['id'];		
		 	if(tmp != 0)
		 	{
		 		setTitle(btnEdit.text);
				isNewRecord = false;
				//editFormDir.getForm().reset();
				setEditable(editViewDir, false);
				editViewDir.show();
				editFormDir.getForm().reset();
				paramValue_parentId.disable();
				paramValue_parentId.setValue(treetmp);
		 	  	fillFormDir(editFormDir);
		 	  	dir_creator.show();
		 	  	var DateForShowValue = record.data.createDate;
				DateForShowValue=DateForShowValue.replace('T', ' ' );
				DateForShow.setValue(DateForShowValue);
				dir_DateForShow.show(); 
				paramValue_parentId.setValue(selNode.attributes.parentId);
		 	}
		 	else
		 	{
		 		Ext.MessageBox.alert('${app:i18n('prompt')}','${app:i18n('rootuneditable')}');
		 	}					
		}
		
		function fillFormDir(item) {
			var fieldName = item.name;
			if (item.isXType('checkbox') && item.relateName) {
				fieldName = eval(item.relateName + ".name");
			}
			if (fieldName != undefined) {
				fieldName = fieldName.substring(fieldName.indexOf('.') + 1, fieldName.length);
				var value = record.data[fieldName];
					if ((item.isXType('datefield') || item.isXType('timefield')) && (value.length == 19)) {
						value = value.replace('T', ' ' );
    						value = Date.parseDate(value, "Y-m-d H:i:s");
    						value = value.format(item.format);
					} else if (item.isXType('checkbox')) {
						value = (value == item.trueValue) ? true : false;
					}
					item.setValue(value);
				}

			if (item.items && item.items.getCount() > 0) {
				for(var i = 0; i < item.items.getCount(); i++) {
					fillFormDir(item.items.get(i));
				}
			}
		}
		//目录删除
		function btnDeleteDir()
		{
			var selNode = distree.getSelectionModel().getSelectedNode();
			if(!selNode) {
				Ext.MessageBox.alert('${app:i18n('prompt')}','${app:i18n('chooserToDelete')}');
				return;
			}
		    gridViewDir.getSelectionModel().selectAll();
			record = gridViewDir.getSelectionModel().getSelections()[0];
			var tmp = record.data['id'];
			if (record.length < 1) {
				Ext.MessageBox.alert('${app:i18n('prompt')}', '${app:i18n('selectDeleteData')}');
			} 
			else 
			{
				if(tmp==0)
				{
					Ext.MessageBox.alert('${app:i18n('prompt')}','${app:i18n('rootundeleteable')}');
				}
				else
				{
					if(tmpchidnode.length>0)
					{
					 Ext.MessageBox.confirm('${app:i18n('prompt')}','${app:i18n('haschildnode')}', deleteRecordDir);
					}
					else
					{
					 Ext.MessageBox.confirm('${app:i18n('prompt')}','${app:i18n('confirmDeleteData')}', deleteRecordDir);
					}
					
				}
			}		
		}
		function deleteRecordDir(result) {
			if (result == 'yes') {
				var records = gridViewDir.getSelectionModel().getSelections();
				var ids = '';
				for(var i = 0; i < records.length; i++) {
				  ids += records[i].data.id + ',';
				}

				Ext.Ajax.request({params: {ids: ids},
					url: "../sysparam/deleteParamValues.action",
					success: function(response) {
						var resp = Ext.util.JSON.decode(response.responseText);
						if (resp.status == "ok") {
							Ext.MessageBox.alert('${app:i18n('prompt')}','${app:i18n('deleteSuccess')}');
							distree.root.reload();
							gridView.getStore().load();
						} else {
							Ext.MessageBox.alert('${app:i18n('deleteFailure')}', resp.status);
						}
					}
				});
			}
		}
		//目录编辑窗口打开
		function editdirView()
		{
			dirView.show();
		}
		//取消按钮
		function  btncancel()
		{
			dirView.hide();
		}
		//确定并关闭按钮
		function btnconfirm()
		{
			dirView.hide();
			paramValue_parentId.setValue(treetmp);			
		}
 
		//目录搜索树
		function onSearchDir() {				
						gridViewDir.getStore().baseParams = queryView.getForm().getValues();
						gridViewDir.getStore().baseParams["limit"] = pagingBar.pageSize;
						gridViewDir.getStore().load();					
				}
	    //树的右键菜单 
      distree.on("contextmenu",function(node,e)
        {   e.preventDefault();  
            var myMenu = new Ext.menu.Menu
            ([               
				{xtype:"button",text:"展开全部",pressed:true,handler:function(){distree.expandAll();}},
             	{xtype:"button",text:"关闭全部",pressed:true,handler:function(){distree.collapseAll();}},  
             	{xtype:"button",text:"刷新",pressed:true,handler:function(){distree.root.reload();}}  
            ]);
            myMenu.showAt(e.getXY());
        }); 
        //树的保存
		function onSaveDir()
		{
			if (isNewRecord == false) {
				setEditable(editView, true);
			}
			if(isDirCheck())
			{
			 editFormDir.saveParamValue();
			}
			else
			{
			 Ext.MessageBox.alert('${app:i18n('prompt')}','${app:i18n('noSelf')}'); 
			 paramValue_parentId.disable();
			}
					
		}
		//dir不能同名
		function isDirCheck()
		{
		 paramValue_parentId.enable();
		 if((paramValue_id.getValue().length!=0) &&(paramValue_id.getValue()==paramValue_parentId.getValue()) )
		 {
		   return false;
		   paramValue_parentId.disable();
		 }
		 else
		 {
			 return true;
		 }
		}
		//树的保存成功
		function showSaveSuccessInfoDir(form, action) {
			if (action.result.status == "ok") {
				Ext.MessageBox.alert('${app:i18n('prompt')}', '${app:i18n('saveSuccess')}');				
				distree.root.reload();
				ds.load();	
				editViewDir.hide();
			} else {
				Ext.MessageBox.alert('${app:i18n('saveFailure')}', action.result.status);
				if (isNewRecord == false) {
					setEditable(editViewDir, false);
				}
			}
		}
		var isNewRecord;
		var record;
 		var Y ="Y";
 		var N ="N";
		function checkboxClick() {
			if (this.relateName) {
				var s = this.relateName + ".setValue(" + (this.checked ? this.trueValue : this.falseValue) + ")";
				eval(s);
			} else if (gridEventObj) {
				gridEventObj.grid.value = this.checked ? this.trueValue : this.falseValue;
			}
		}

		function checkboxRenderer(v, p, r) {
			var trueValue = eval(this.id + '.trueValue');
			p.css += ' x-grid3-check-col-td';
			return '<div class="x-grid3-check-col'+((v==trueValue)?'-on':'')+' x-grid3-cc-'+this.id+'">&#160;</div>';
		}

		function datetimeRenderer(v, p, r) {
			if ((v == null) || (v.length < 19)) return v;
			var dateFormat = eval(this.id + '.format');
			if (typeof(v) == "string") {
				v = v.replace('T', ' ' );
				v = Date.parseDate(v, "Y-m-d H:i:s");
			}
			return v.format(dateFormat);
		}
		
	 	
		function getSlaveValue(item) {
			if (item.isXType("editorgrid")) {
				var rs = new Array();
				var i = 0;
				item.getStore().each(function(r) { rs[i++] = r.data; });
				var json =  Ext.util.JSON.encode(rs) ;
				exaExamArrange_slaves.setValue(exaExamArrange_slaves.getValue() + json);
			}

			if (item.items && item.items.getCount() > 0) {
				for(var i = 0; i < item.items.getCount(); i++) {
					getSlaveValue(item.items.get(i));
				}
			}
		}
		
		function parseDate(value, format) {
			if ((value == null) || (value.length < 19)) return value;
			value = value.replace('T', ' ' );
			value = Date.parseDate(value, "Y-m-d H:i:s");
			return value.format(format);
		}
		
		
		function comboboxRenderer(v, p, r) {
			if (v != null) {
				var records = eval(this.id + '.initialConfig.store.getRange()');
				var keyField = eval(this.id + '.valueField');
				var displayField = eval(this.id + '.displayField');
				for(var i = 0; i < records.length; i ++) {
					var record = records[i];
					if (record.get(keyField) == v) {
						return record.get(displayField);
					}
				}
			}
			return v;
		}

		function comboBoxdoQuery(item) {
			if (item.isXType('combo')) {
				item.doQuery("", true);
			} else if (item.isXType('grid') || item.isXType('editorgrid')) {
				var model = item.getColumnModel();
				for(var i = 0; i < model.getColumnCount(); i++) {
					var column = model.getColumnById(model.getColumnId(i));
					var editor = column.editor;
					if (editor && editor.isXType('combo')) {
						editor.doQuery("", true);
					}
				}
			}
			if (item.items && item.items.getCount() > 0) {
				for(var i = 0; i < item.items.getCount(); i++) {
					comboBoxdoQuery(item.items.get(i));
				}
			}
		}

		function onUIShow() {
			var mainView = queryView.ownerCt;
			var queryHeight = queryView.getInnerHeight() + queryView.getFrameHeight();
			gridView.setPosition(0, queryHeight);
			gridView.setHeight(mainView.getInnerHeight() - queryHeight);

			comboBoxdoQuery(mainView);
			comboBoxdoQuery(editView);
		}

		function initComboBox() {
			if (!this.initialized) {
				this.initialized = true;
				//var TYPE = Ext.data.Record.create([{name:this.valueField}, {name:this.displayField}]);
				//var r = eval('new TYPE({' + this.valueField + ':"",' + this.displayField + ':"---"});');
				//this.store.insert(0, r);
			}
		}

			function fillForm(item) {
			var fieldName = item.name;
			if (item.isXType('checkbox') && item.relateName) {
				fieldName = eval(item.relateName + ".name");
			}
			if (fieldName != undefined) {
				fieldName = fieldName.substring(fieldName.indexOf('.') + 1, fieldName.length);
				var value = record.data.exaExamArrange[fieldName];
				if (value != undefined) {
					if ((item.isXType('datefield') || item.isXType('timefield')) && (value.length == 19)) {
						value = value.replace('T', ' ' );
						value = Date.parseDate(value, "Y-m-d H:i:s");
						value = value.format(item.format);
					} else if (item.isXType('checkbox')) {
						value = (value == item.trueValue) ? true : false;
					}
					item.setValue(value);
				}
			}

			if (item.items && item.items.getCount() > 0) {
				for(var i = 0; i < item.items.getCount(); i++) {
					fillForm(item.items.get(i));
				}
			}
		}

		function setEditable(item, canEdit) {
			if (item.modifytable == "false") {
				if (canEdit == true) {
					item.enable();
				} else {
					item.disable();
				}
			}
			if (item.items && item.items.getCount() > 0) {
				for(var i = 0; i < item.items.getCount(); i++) {
					setEditable(item.items.get(i), canEdit);
				}
			}
		}

		function onSearch() {
			if (queryView.getForm().isValid() == false) {
				Ext.MessageBox.alert('${app:i18n('prompt')}', '${app:i18n('validateError')}');
			} else {
			  //alert(query_testpaperUrl.getValue());  
			  //alert(query_examType.getValue());
				query_id.setValue(null);
				var tmp= queryView.getForm().getValues();
				gridView.getStore().baseParams = queryView.getForm().getValues();
				gridView.getStore().baseParams["limit"] = pagingBar.pageSize;
				gridView.getStore().load();
			}
		}
		// 试卷树搜索
		function onSelectNodePaper(node)
		{
			query_testpaperUrl2.setValue(node.id);
			if (query_testpaperUrl2.rendered == true) {
				query_testpaperUrl2.originalValue = node.id;
			} else {
				query_testpaperUrl2.setValue(node.id);
			}
			onSearchPaper();
		}
		//试卷搜索
		function onSearchPaper() {
			if (paperQueryView.getForm().isValid() == false) {
				Ext.MessageBox.alert('${app:i18n('prompt')}', '${app:i18n('validateError')}');
			} else {
				query_id.setValue(null); 
				paperGridView.getStore().baseParams =paperQueryView.getForm().getValues();
				paperGridView.getStore().baseParams["limit"] = pagingBar.pageSize;
				paperGridView.getStore().baseParams["query.isFinalSave"] = 'Y';
				paperGridView.getStore().load();
			}
		}

		function onExport() {
			if (queryView.getForm().isValid() == false) {
				Ext.MessageBox.alert('${app:i18n('prompt')}', '${app:i18n('validateError')}');
			} else {
				var params = queryView.getForm().getValues(true);
				window.location = "exportExaExamArrange.action?" + params;
			}
		}

		function setTitle(title) {
			if ((title != null) && (title.length > 0)) {
				var ch = title.substr(title.length - 1, 1);
				if (((ch >= 'a') && (ch <= 'z')) || ((ch >= 'A') && (ch <= 'Z'))) {
					title = title + ' ';
				}
			}
			editView.setTitle(title + "${app:i18n('exaExamArrange')}");
		}
        var btnSaveFlag = false ;
		function onAdd() {	
		  var node=distree.getSelectionModel().getSelectedNode();
		  if(node==null||node.id==0){
		     Ext.MessageBox.alert('${app:i18n('prompt')}', '请选择考试分类。');
		     return;
		  }	
		  if(node.id==45){
		     Ext.MessageBox.alert('${app:i18n('prompt')}', '不能在根结点上创建。');
		     return;
		  }	
		  //=======自动获取考试编号
		  Ext.Ajax.request({
		                params: {examType:23},
						url: "makeExamNoAndDept.action",
						success: function(response) {
							var resp = Ext.util.JSON.decode(response.responseText);
							exaExamArrange_examNo.setValue(resp.examNo);
							exaExamArrange_createDeptName_submit.setValue(resp.createDeptName);
							exaExamArrange_parentDeptCode_submit.setValue(resp.parentDeptCode);
							exaExamArrange_parentDeptName_submit.setValue(resp.parentDeptName);
							
						}
					});	
			//=======自动获取考试编号	  
		    isAddOrEdit=0;
			ctp.setVisible(false);
			ctp1.setVisible(false);
			ctr.setVisible(false);
			setTitle(btnAdd.text);
			isNewRecord = true;
			//editForm.getForm().reset();
   			selectedPaper.getStore().removeAll();
   			clearGrid(editView);
			setEditable(editView, true);
			btnSave.disable();
			editView.show();
			editForm.getForm().reset();
            btnSaveFlag=true;
            btnSave.enable(); 
            btnvalidation.hide();
			exaExamArrange_testpaperUrl.setValue(tmpqueryid);
			exaExamArrange_testParamValue.setValue(node.text);
		}
		function clearGrid(item) {
			if (item.isXType("editorgrid")) {
				item.getStore().removeAll();
			}
			if (item.items && item.items.getCount() > 0) {
				for(var i = 0; i < item.items.getCount(); i++) {
					clearGrid(item.items.get(i));
				}
			}
		}
		function onView(){
			if (gridView.getSelectionModel().getSelections().length != 1) {
				Ext.MessageBox.alert('${app:i18n('prompt')}','${app:i18n('selectOneRecord')}');
				return;
			}
			ctp.setVisible(false);
			record = gridView.getSelectionModel().getSelections()[0];
			//===填充非自动信息			
			var	dataexamName =record.data['examName'];
			var	datacreateDeptName =record.data['createDeptName'];
			var	dataparentDeptCode =record.data['parentDeptCode'];
			var	dataparentDeptName =record.data['parentDeptName'];
			exaExamArrange_selfDef_examName_copy.hide();
			//===填充非自动信息
			var dataString = record.data['createDate'];
			dataString = dataString.replace('T', ' ' );		 			
			//var createDeptStr = record.data['createDept'];
			ctp1.setVisible(true);
			ctr.setVisible(true);
			btnReset.setVisible(false);
			isAddOrEdit=1;
			setTitle(btnEdit.text);
			isNewRecord = false;
			//editForm.getForm().reset();
			clearGrid(editView);
			setEditable(editView, false);
			btnSave.disable();
			editView.setTitle("查看考试安排");
			editView.show();
			editForm.getForm().reset();
			btnvalidation.show();
			exaExamArrange_createDate1.setValue(dataString);
			//===填充非自动信息
			exaExamArrange_examName.setValue(dataexamName);
			exaExamArrange_createDeptName_submit.setValue(datacreateDeptName);
			exaExamArrange_parentDeptCode_submit.setValue(dataparentDeptCode);
			exaExamArrange_parentDeptName_submit.setValue(dataparentDeptName);
			//===填充非自动信息
			Ext.Ajax.request({url:'../testarrange/findExaExamArrange.action',
				method: 'post',
				sync:'true',
				params: {'exaExamArrange.id' : gridView.getSelectionModel().getSelections()[0].data.id},
				success: function(response, action) {
					record = new Ext.data.Record(Ext.util.JSON.decode(response.responseText));
					fillForm(editForm);
					min_Date.setValue(record.data.minDate);
					var count_=new Number(record.data.recordCount);
					if(count_>0)
					{
					 //填充非原始的框
					 for(var ct = 1;ct< count_;ct++)
					 { 	
					 	var recordn = record;
					  	addStu();
					  	var kk = recordn.data.exaExamArrange.exaExamRelatives.length;
					  	var begintime_1  ;
					  	var endtime_1;
						for(var k=0;k< kk;k++)
						{
						   if(recordn.data.exaExamArrange.exaExamRelatives[k].arrangeGroup==ct)
						   {
						    	var ExaExamRelative = Ext.data.Record.create([{name:"id"},{name:"examId"},{name:"effectStart"},{name:"effectEnd"},{name:"userName"},{name:"userGroup"},{name:"examTime"},{name:"judgeUser"},{name:"userRealname"},{name:"arrangeGroup"},{name:"userEmail"},{name:"groupId"}]);
								var r2 = new ExaExamRelative({id:recordn.data.exaExamArrange.exaExamRelatives[k].id ,examId:recordn.data.exaExamArrange.exaExamRelatives[k].examId,effectStart:recordn.data.exaExamArrange.exaExamRelatives[k].effectStart,effectEnd:recordn.data.exaExamArrange.exaExamRelatives[k].effectEnd,userName:recordn.data.exaExamArrange.exaExamRelatives[k].userName,userGroup:recordn.data.exaExamArrange.exaExamRelatives[k].userGroup,examTime:recordn.data.exaExamArrange.exaExamRelatives[k].examTime,judgeUser:null,userRealname:recordn.data.exaExamArrange.exaExamRelatives[k].userRealname,arrangeGroup:recordn.data.exaExamArrange.exaExamRelatives[k].arrangeGroup,userEmail:recordn.data.exaExamArrange.exaExamRelatives[k].userEmail,groupId:recordn.data.exaExamArrange.exaExamRelatives[k].groupId});
							 	var store_tmp=  Ext.getCmp(ct).items.items[3].getStore();
							    store_tmp.insert(0, r2);
							    begintime_1	= recordn.data.exaExamArrange.exaExamRelatives[k].effectStart;
							    endtime_1 = recordn.data.exaExamArrange.exaExamRelatives[k].effectEnd;
						   }
						}
						//var id_1 = "begintime"+ct;
		   				//var id_2 = "endtime"+ct;
						begintime_1 = begintime_1.replace('T', ' ' );	
						endtime_1 = endtime_1.replace('T', ' ' );	
		   				var store_tmp=  Ext.getCmp(ct).items.items[1].setValue(begintime_1);
		   				var store_tmp=  Ext.getCmp(ct).items.items[2].setValue(endtime_1);
		   				 
					  }
					 //填充原始框 
					    var recordn = record;
					    var kk = recordn.data.exaExamArrange.exaExamRelatives.length;
						for(var k=0;k< kk;k++)
						{
						   if(recordn.data.exaExamArrange.exaExamRelatives[k].arrangeGroup==0)
						   {
						    	var ExaExamRelative = Ext.data.Record.create([{name:"id"},{name:"examId"},{name:"effectStart"},{name:"effectEnd"},{name:"userName"},{name:"userGroup"},{name:"examTime"},{name:"judgeUser"},{name:"userRealname"},{name:"arrangeGroup"},{name:"userEmail"},{name:"groupId"}]);
								var r2 = new ExaExamRelative({id:recordn.data.exaExamArrange.exaExamRelatives[k].id ,examId:recordn.data.exaExamArrange.exaExamRelatives[k].examId,effectStart:recordn.data.exaExamArrange.exaExamRelatives[k].effectStart,effectEnd:recordn.data.exaExamArrange.exaExamRelatives[k].effectEnd,userName:recordn.data.exaExamArrange.exaExamRelatives[k].userName,userGroup:recordn.data.exaExamArrange.exaExamRelatives[k].userGroup,examTime:recordn.data.exaExamArrange.exaExamRelatives[k].examTime,judgeUser:null,userRealname:recordn.data.exaExamArrange.exaExamRelatives[k].userRealname,arrangeGroup:recordn.data.exaExamArrange.exaExamRelatives[k].arrangeGroup,userEmail:recordn.data.exaExamArrange.exaExamRelatives[k].userEmail,groupId:recordn.data.exaExamArrange.exaExamRelatives[k].groupId});
							    exaExamRelativeGrid.getStore().insert(0, r2);
						   }
						}	
					}
					else
					{
					 fillGrid(exaExamRelativeGrid);		
					}	  					  
					//试卷获取
					var tmp =exaExamArrange_testpaperId.getValue();
					selectedPaper.getStore().baseParams['query.id'] =  tmp;
					selectedPaper.getStore().baseParams['query.isFinalSave'] =  'Y';
					selectedPaper.getStore().load();
				}
			}); 
			query_createMethod3.setValue(save_createMethod.getValue());
		}

		function onEdit() {
			if (gridView.getSelectionModel().getSelections().length != 1) {
				Ext.MessageBox.alert('${app:i18n('prompt')}','${app:i18n('selectOneRecord')}');
				return;
			}
			record = gridView.getSelectionModel().getSelections()[0];
			//===填充非自动信息
			
			var	dataexamName =record.data['examName'];
			var	datacreateDeptName =record.data['createDeptName'];
			var	dataparentDeptCode =record.data['parentDeptCode'];
			var	dataparentDeptName =record.data['parentDeptName'];
			exaExamArrange_selfDef_examName_copy.hide();
			//===填充非自动信息
			ctp.setVisible(false);
			//record = gridView.getSelectionModel().getSelections()[0];
			var dataString = record.data['createDate'];
			dataString = dataString.replace('T', ' ' );		 			
			ctp1.setVisible(true);
			ctr.setVisible(true);
			btnReset.setVisible(false);
			isAddOrEdit=1;
			setTitle(btnEdit.text);
			isNewRecord = false;
			//editForm.getForm().reset();
			clearGrid(editView);
			setEditable(editView, false);
			btnSave.disable();
			editView.show();
			editForm.getForm().reset();
			btnvalidation.show();
			exaExamArrange_createDate1.setValue(dataString);
			//===填充非自动信息
			exaExamArrange_examName.setValue(dataexamName);
			exaExamArrange_createDeptName_submit.setValue(datacreateDeptName);
			exaExamArrange_parentDeptCode_submit.setValue(dataparentDeptCode);
			exaExamArrange_parentDeptName_submit.setValue(dataparentDeptName);
			//===填充非自动信息
			Ext.Ajax.request({url:'../testarrange/findExaExamArrange.action',
				method: 'post',
				sync:'true',
				params: {'exaExamArrange.id' : gridView.getSelectionModel().getSelections()[0].data.id},
				success: function(response, action) {
					record = new Ext.data.Record(Ext.util.JSON.decode(response.responseText));
					fillForm(editForm);
					min_Date.setValue(record.data.minDate);
					var count_=new Number(record.data.recordCount);
					if(count_>0)
					{
					 //填充非原始的框
					 for(var ct = 1;ct< count_;ct++)
					 { 	
					 	var recordn = record;
					  	addStu();
					  	var kk = recordn.data.exaExamArrange.exaExamRelatives.length;
					  	var begintime_1  ;
					  	var endtime_1;
						for(var k=0;k< kk;k++)
						{
						   if(recordn.data.exaExamArrange.exaExamRelatives[k].arrangeGroup==ct)
						   {
						    	var ExaExamRelative = Ext.data.Record.create([{name:"id"},{name:"examId"},{name:"effectStart"},{name:"effectEnd"},{name:"userName"},{name:"userGroup"},{name:"examTime"},{name:"judgeUser"},{name:"userRealname"},{name:"arrangeGroup"},{name:"userEmail"},{name:"groupId"}]);
								var r2 = new ExaExamRelative({id:recordn.data.exaExamArrange.exaExamRelatives[k].id ,examId:recordn.data.exaExamArrange.exaExamRelatives[k].examId,effectStart:recordn.data.exaExamArrange.exaExamRelatives[k].effectStart,effectEnd:recordn.data.exaExamArrange.exaExamRelatives[k].effectEnd,userName:recordn.data.exaExamArrange.exaExamRelatives[k].userName,userGroup:recordn.data.exaExamArrange.exaExamRelatives[k].userGroup,examTime:recordn.data.exaExamArrange.exaExamRelatives[k].examTime,judgeUser:null,userRealname:recordn.data.exaExamArrange.exaExamRelatives[k].userRealname,arrangeGroup:recordn.data.exaExamArrange.exaExamRelatives[k].arrangeGroup,userEmail:recordn.data.exaExamArrange.exaExamRelatives[k].userEmail,groupId:recordn.data.exaExamArrange.exaExamRelatives[k].groupId});
							 	var store_tmp=  Ext.getCmp(ct).items.items[3].getStore();
							    store_tmp.insert(0, r2);
							    begintime_1	= recordn.data.exaExamArrange.exaExamRelatives[k].effectStart;
							    endtime_1 = recordn.data.exaExamArrange.exaExamRelatives[k].effectEnd;
						   }
						}
						//var id_1 = "begintime"+ct;
		   				//var id_2 = "endtime"+ct;
						begintime_1 = begintime_1.replace('T', ' ' );	
						endtime_1 = endtime_1.replace('T', ' ' );	
		   				var store_tmp=  Ext.getCmp(ct).items.items[1].setValue(begintime_1);
		   				var store_tmp=  Ext.getCmp(ct).items.items[2].setValue(endtime_1);
		   				 
					  }
					 //填充原始框 
					    var recordn = record;
					    var kk = recordn.data.exaExamArrange.exaExamRelatives.length;
						for(var k=0;k< kk;k++)
						{
						   if(recordn.data.exaExamArrange.exaExamRelatives[k].arrangeGroup==0)
						   {
						    	var ExaExamRelative = Ext.data.Record.create([{name:"id"},{name:"examId"},{name:"effectStart"},{name:"effectEnd"},{name:"userName"},{name:"userGroup"},{name:"examTime"},{name:"judgeUser"},{name:"userRealname"},{name:"arrangeGroup"},{name:"userEmail"},{name:"groupId"}]);
								var r2 = new ExaExamRelative({id:recordn.data.exaExamArrange.exaExamRelatives[k].id ,examId:recordn.data.exaExamArrange.exaExamRelatives[k].examId,effectStart:recordn.data.exaExamArrange.exaExamRelatives[k].effectStart,effectEnd:recordn.data.exaExamArrange.exaExamRelatives[k].effectEnd,userName:recordn.data.exaExamArrange.exaExamRelatives[k].userName,userGroup:recordn.data.exaExamArrange.exaExamRelatives[k].userGroup,examTime:recordn.data.exaExamArrange.exaExamRelatives[k].examTime,judgeUser:null,userRealname:recordn.data.exaExamArrange.exaExamRelatives[k].userRealname,arrangeGroup:recordn.data.exaExamArrange.exaExamRelatives[k].arrangeGroup,userEmail:recordn.data.exaExamArrange.exaExamRelatives[k].userEmail,groupId:recordn.data.exaExamArrange.exaExamRelatives[k].groupId});
							    exaExamRelativeGrid.getStore().insert(0, r2);
						   }
						}	
					}
					else
					{
					 fillGrid(exaExamRelativeGrid);		
					}	  					  
					//试卷获取
					var tmp =exaExamArrange_testpaperId.getValue();
					selectedPaper.getStore().baseParams['query.id'] =  tmp;
					selectedPaper.getStore().baseParams['query.isFinalSave'] =  'Y';
					selectedPaper.getStore().load();
				}
			}); 
			query_createMethod3.setValue(save_createMethod.getValue());
		}
		
		

		function onDelete() {
			var records = gridView.getSelectionModel().getSelections();
			if (records.length < 1) {
				Ext.MessageBox.alert('${app:i18n('prompt')}', '${app:i18n('selectDeleteData')}');
			} else {
				Ext.MessageBox.confirm('${app:i18n('prompt')}','${app:i18n('confirmDeleteArrang')}', deleteRecord);
			}
		}

		function deleteRecord(result) {
			if (result == 'yes') {
				var records = gridView.getSelectionModel().getSelections();
				var ids = '';
				for(var i = 0; i < records.length; i++) {
				  ids += records[i].data.id + ',';
				}

				Ext.Ajax.request({params: {ids: ids},
					url: "deleteExaExamArranges.action",
					success: function(response) {
						var resp = Ext.util.JSON.decode(response.responseText);
						if (resp.status == "ok") {
							Ext.MessageBox.alert('${app:i18n('prompt')}','${app:i18n('deleteSuccess')}');
							gridView.getStore().load();
						} else {
							Ext.MessageBox.alert('${app:i18n('deleteFailure')}', resp.status);
						}
					}
				});
			}
		}

		function onReset() {
			editForm.getForm().reset();
			clearGrid(editView);
			if (isNewRecord == false) {
				fillForm(editForm);
				fillGrid(editView);
			}
		}
		
		 function getGridDateField(grid) {
			var fields = new Array();
			var model = grid.getColumnModel();
			for(var i = 0; i < model.getColumnCount(); i++) {
				var column = model.getColumnById(model.getColumnId(i));
				var editor = column.editor;
				if (editor && editor.format && (editor.isXType('datefield') || editor.isXType('timefield'))) {
					var field = new Object();
					field.dataIndex = column.dataIndex;
					field.format = editor.format;
					fields[fields.length] = field;
				}
			}
			return fields;
		}
		
		function fillGrid(item) {			
			if (item.isXType("editorgrid")) {
				var records = record.data.exaExamArrange[item.getStore().reader.meta.root];
				var dateFields = getGridDateField(item);
				for(var i = 0; i < dateFields.length; i++) {
					var field = dateFields[i];
					for(var j = 0; j < records.length; j++) {
						var r = records[j];
						r[field.dataIndex] = parseDate(r[field.dataIndex], field.format);
					}
				}
				item.getStore().loadData(record.data.exaExamArrange);
			}
			if (item.items && item.items.getCount() > 0) {
				for(var i = 0; i < item.items.getCount(); i++) {
					fillGrid(item.items.get(i));
				}
			}
		}
		//填充多个面板
		function fillGridMuti(item,record) {					
			if (item.isXType("editorgrid")) {
				var records = record;
				var dateFields = getGridDateField(item);
				for(var i = 0; i < dateFields.length; i++) {
					var field = dateFields[i];
					for(var j = 0; j < records.length; j++) {
						var r = records[j];
						r[field.dataIndex] = parseDate(r[field.dataIndex], field.format);
					}
				}
				item.getStore().loadData(record.data.exaExamArrange);
			}
			if (item.items && item.items.getCount() > 0) {
				for(var i = 0; i < item.items.getCount(); i++) {
					fillGrid(item.items.get(i));
				}
			}
		}


		function onSave() {
            if(exaExamArrange_examName.getRawValue()=='自主考试'){
				   if(exaExamArrange_selfDef_examName.getValue()==''||exaExamArrange_selfDef_examName.getValue()==null){
 							Ext.MessageBox.alert('${app:i18n('prompt')}', '自主考试名称不能为空！！');
		       				return ;
					}
			}
		    if(!btnSaveFlag)
		    {
		        Ext.MessageBox.alert('${app:i18n('prompt')}', '请先点击校验');
		        return ;
		    }
		//======自动填写考试名
        if(exaExamArrange_examName.getRawValue().substring(0,4)=="自主考试"){
        exaExamArrange_examName_submit.setValue(exaExamArrange_selfDef_examName.getValue()); 
        //alert(exaExamArrange_examName_submit.getValue());    
        }else{
        exaExamArrange_examName_submit.setValue(exaExamArrange_examName.getRawValue());        
        }
			selectedPaper.getSelectionModel().selectAll();
			var records = selectedPaper.getSelectionModel().getSelections();
			var name =exaExamArrange_examName.getRawValue();
			if (records.length < 1) {
				Ext.MessageBox.alert('${app:i18n('prompt')}', '${app:i18n('pleaseChooseApaper')}');
			}else if(name == ''){
			   Ext.MessageBox.alert('${app:i18n('prompt')}', '${app:i18n('exam_select_arrange')}');
			}
			else
			{  
			    
				record = selectedPaper.getSelectionModel().getSelections()[0];						    
				exaExamArrange_testpaperId.setValue(record.data['id']);
				exaExamArrange_testpaperName.setValue(record.data['testpaperName']);
				if(name == '自主考试'&&exaExamArrange_selfDef_examName.getValue() ==''){
				 Ext.MessageBox.alert('${app:i18n('prompt')}', '${app:i18n('self_exaname_not_null')}');
			     return;
				}
				if(!timeChanged())
				return;
				if(!timeChanged2())
				return;
				exaExamArrange_slaves.setValue('');
				getSlaveValue(editView);
				editForm.saveExaExamArrange();
			}
		 
	}
	function gridIsValid(grid) {
			var columns = new Array();
			var model = grid.getColumnModel();
			for(var i = 0; i < model.getColumnCount(); i++) {
				var column = model.getColumnById(model.getColumnId(i));
				if (column.editor) {
					columns[columns.length] = column;
				}
			}

			var isValid = true;
			grid.getStore().each(function(r) {
			for(var i = 0; i < columns.length; i++) {
				var column = columns[i];
				var editor = column.editor;
				var value = r.get(column.dataIndex);
				editor.setValue((typeof(value) == "string") ? value.trim() : value);
				isValid = editor.isValid();
				if (!isValid) {
					return false;
				}
			}});

			return isValid;
		}

		function checkGrid(item, result) {
			if (result.valid) {
				if (item.isXType("editorgrid")) {
					if (!gridIsValid(item)) {
						result.valid = false;
					}
				}
				
				if (item.items && item.items.getCount() > 0) {
					for(var i = 0; i < item.items.getCount(); i++) {
						checkGrid(item.items.get(i), result);
					}
				}
			}
		}
		
		function checkSave() {
			var isValid = editForm.getForm().isValid();
			if (isValid) {
				var result = new Object();
				result.valid = true;
				checkGrid(editView, result);
				isValid = result.valid;
			}
			
			if (!isValid) {
				Ext.MessageBox.alert('${app:i18n('prompt')}', '${app:i18n('validateError')}');
			}
			return isValid;
		}
		
		function showSaveSuccessInfo(form, action) {
			if (action.result.status == "ok") {
				Ext.MessageBox.alert('${app:i18n('prompt')}', '${app:i18n('saveSuccess')}');
				editView.hide();
				onSearch();
			} else {
				Ext.MessageBox.alert('${app:i18n('saveFailure')}', action.result.status);
				if (isNewRecord == false) {
					setEditable(editView, false);
				}
			}
		}

		function showSaveFailureInfo(form, action) {
			if (action.failureType == "client") {
				Ext.MessageBox.alert('${app:i18n('prompt')}', '${app:i18n('validateError')}');
			} else {
				Ext.MessageBox.alert('${app:i18n('prompt')}', '${app:i18n('saveFailure')}');
			}
			if (isNewRecord == false) {
				setEditable(editView, false);
			}
		}
		function addStu(){
		    stuIndex=stuIndex+1;
		    var id_1 = "begintime"+stuIndex;
		    var id_2 = "endtime"+stuIndex;
		    var tmp =new Ext.Panel({layout:"form",id:stuIndex
						  ,items: [
						  new Ext.Panel({html:"安排信息&nbsp;&nbsp;<a href='javascript:beforeDelStu("+stuIndex+")'>删除该安排</a>"})
						    ,new Ext.form.DateField({width:240,fieldLabel:"开始时间<font color='red'>*</font>", id:id_1,format:"Y-m-d H:i:s",listeners:{change:DateChange,focus:focusFunction}})
							,new Ext.form.DateField({width:240,fieldLabel:"结束时间<font color='red'>*</font>", id:id_2,format:"Y-m-d H:i:s",listeners:{change:DateChange,focus:focusFunction}})  
                            ,addRelative(stuIndex)
						]});
		    c.add(tmp);
		    c.doLayout(); 
		}
		function addRelative(stuIndex)
		{
		  var edti ="exaExamRelativeGrid"+stuIndex;
		  edti =new Ext.grid.EditorGridPanel({enableHdMenu:false,autoExpandColumn:"exaExamRelative_id",frame:true,maxHeight:300,autoScroll:true,clicksToEdit:1,region:"center",autoHeight:true,listeners:{beforeedit: gridBeforeEdit, afteredit: gridAfterEdit},id:"com.sf.module.testarrange.domain.ExaExamRelative"
								,tbar: [
									new Ext.Button({handler:firstOnDeleteExaExamRelative,text:"删除",cls:"x-btn-normal",location: stuIndex})
									,new Ext.Button({handler:firstShowuser,text:"新增",cls:"x-btn-normal",location: stuIndex })  
										]
								,store:  new Ext.data.Store({remoteSort:false
									,reader: new Ext.data.JsonReader({root:"exaExamRelatives"
										,fields: [{name: "userName"},{name: "userRealname"},{name: "examId"},{name: "examTime"},{name: "effectEnd"},{name: "userGroup"},{name: "effectStart"},{name: "judgeUser"},{name: "id"},{name: "code"}
												 ]
									},null)
								})
								,sm: new Ext.grid.RowSelectionModel({ })
								,cm: new Ext.grid.ColumnModel([
									{width:40,renderer:initRowIndex1,dataIndex:"rn|"+stuIndex},
									{hidden:true,header:"考试ID",dataIndex:"id",id:"exaExamRelative_id" }
									,{hidden:true,header:"考试编号",dataIndex:"examId",id:"exaExamRelative_examId"
										,editor: exaExamRelative_examId
									}
									,{renderer:datetimeRenderer,hidden:true,header:"考试开始",dataIndex:"effectStart",id:"exaExamRelative_effectStart"
										,editor: exaExamRelative_effectStart
									}
									,{renderer:datetimeRenderer,hidden:true,header:"考试结束",dataIndex:"effectEnd",id:"exaExamRelative_effectEnd"
										,editor: exaExamRelative_effectEnd
									}
									,{header:"员工编号",dataIndex:"userName",id:"exaExamRelative_userId"
										,editor: exaExamRelative_userId
									}
									,{hidden:true,header:"员工组织",dataIndex:"userGroup",id:"exaExamRelative_userGroup"
										,editor: exaExamRelative_userGroup
									}
									,{hidden:true,header:"已考次数",dataIndex:"examTime",id:"exaExamRelative_examTime"
										,editor: exaExamRelative_examTime
									}
									,{hidden:true,header:"评卷人",dataIndex:"judgeUser",id:"exaExamRelative_judgeUser"
										,editor: exaExamRelative_judgeUser
									}
									,{width:190,header:"姓名",dataIndex:"userRealname",id:"exaExamRelative_userRealname"
										,editor: exaExamRelative_userRealname
									}
								])
							})
							return edti;
		}
		
		function beforeDelStu(i){
			if(deptCodeTreeSelect=='${deptCode}'){			
				delStu(i);
			}
		}
		function delStu(i){
		     var tmp_count222 = Ext.getCmp(i).items.items[3].getStore().getCount();
		     var record=null;
			 if (tmp_count222>0) {
			     for(var jj =0 ; jj< tmp_count222;jj++)
    			 {
    				if(Ext.getCmp(i).items.items[3].getStore().getAt(jj).data.id!=null)
    				{
    				    record = Ext.getCmp(i).items.items[3].getStore().getAt(jj);
    				    break;
    				}
    				 
    			 }
    			 
    			 if(record==null)
			    {
		            stuIndex=stuIndex-1;
        		    var fieldget = Ext.getCmp(i);
        	        c.remove(fieldget);
        	        c.doLayout(); 
			    }
			    
			    else
			    {   
    	            var change_timeBe = Ext.getCmp(i).items.items[1].getValue().format("Y-m-d H:i:s");
			        var t_n = new Date();
            	    t_n = t_n.format("Y-m-d H:i:s");
            	    if(change_timeBe< t_n)
            	    {
            	        Ext.Msg.alert('${app:i18n('prompt')}','该批次已经到了考试时间，不允许删除');  
                        return; 
			        }
			        else
			        {
			            stuIndex=stuIndex-1;
            		    var fieldget = Ext.getCmp(i);
            	        c.remove(fieldget);
            	        c.doLayout(); 
			        }
			    }
			    
				}
				else
				{
			        stuIndex=stuIndex-1;
        		    var fieldget = Ext.getCmp(i);
        	        c.remove(fieldget);
        	        c.doLayout();
				}
		}
		function needManual(o,v){
		    if(v==true){
		        mark.show();
		    }else{
		        mark.hide();
		    } 
		}

 		//获得试卷类型
 		function choosePaparMethod()
 		{	
 			 selectedPaper.getStore().removeAll();
 			 query_createMethod2.setValue(query_createMethod3.getValue());
 			 query_finalMethod.setValue(query_createMethod3.getValue());
 			 save_createMethod.setValue(query_createMethod3.getValue());
 		}
 		function choosePaperByDept(){
 			//alert(deptCodeTreeSelect);
 			if(deptCodeTreeSelect=='${deptCode}' ){ 			
 				choosePaper();
 			}
 		}
		function choosePaper(){
			if(query_createMethod3.getValue()== 0)
			{
				Ext.Msg.alert("错误","请选择试卷类型");
			}
			else
			{
			 if(min_Date.getValue()!="")
			 {
                var t_n = new Date();
        	    t_n = t_n.format("Y-m-d H:i:s");
        	    if(min_Date.getValue()< t_n)
        	    {
        	        Ext.Msg.alert('提示','该安排已经到了考试时间，不允许修改');
        	        return;
        	    }
			 }
			 paperView.show();
			 query_finalMethod.setValue(query_createMethod3.getValue());
			 query_createMethod2.setValue(query_createMethod3.getValue());
			 query_paper_testpaperNo.setValue(null);
			 query_paper_testpaperName.setValue(null);
			 query_paper_testpaperDifficulty.reset();
		     paperGridView.getStore().removeAll();
			}
		     
		}
		function onPaperReset()
		{
			query_paper_testpaperNo.setValue(null);
			query_paper_testpaperName.setValue(null);
			query_paper_testpaperDifficulty.reset();
		}
		function  activeTab(o){
		  
		    tabs.activate(o.location); 
		}
		//确定试卷
		function onSelectPaper(){
		     record=paperGridView.getSelectionModel().getSelections();
		     if (record.length < 1) {
			   	paperView.hide();
			 } 
		    else{
			     selectedPaper.getStore().removeAll();	 
			     selectedPaper.getStore().insert(0, record);	
			     paperView.hide(); 
		        }    
		}
		
		function onNotice()
		{	
			var records = gridView.getSelectionModel().getSelections();
			if (records.length < 1) {
				Ext.MessageBox.alert('${app:i18n('prompt')}', '请选择一条记录。');
			} else {	 
				var ids = '';				 
				for(var i = 0; i < records.length; i++) {
				ids += records[i].data.id + ',';				
				exam_ids.setValue(ids);
				}				
				noticeView.show();
				var now = new Date(); 
				notice_date.setValue(now);
			}					
		}	
		//查找用户
		userListGrid.on("render",function()
		{
			////pagingBars.loading.hide();
			pagingBars.displayMsg="第{0}-{1}共{2}人";
		},this);
	function queryUserHdl(){
     	userListGrid.getStore().removeAll();
        if(empCodeVar.getValue() == "" && usernameVar.getValue() == ""&&deptCodeVar2.getValue()=="")
        {
          Ext.MessageBox.alert('${app:i18n('prompt')}','请至少输入一条查询条件。');
          return;
        }
        if(groupId==null||groupId==''){
        	 setUserListGridStore();
	        
        	//queryUserByDeptCodeStore.baseParams = userQueryForm.getForm().getValues();
		   // queryUserByDeptCodeStore.baseParams["limit"] = pagingBars.pageSize;
		    
		  //  userListGrid.getStore().removeAll();
		    
		  //  queryUserByDeptCodeStore.load({
		    	
		  //  	callback: function(r, options, success){   
			//			     userListGrid.getStore().add(r);
			//			  }//callback 
		  //  });
        }else{
        	userListGrid.getStore().baseParams = userQueryForm.getForm().getValues();
	        userListGrid.getStore().baseParams["limit"] = pagingBars.pageSize;
	        userListGrid.getStore().load();
        }
        
	    
       
    }
    //重置 搜索条件
    function onUserRest()
    {
    	userQueryForm.getForm().reset();
    	empCodeVar.setValue("");
    	userFormPanel2.getForm().reset();
    }
    //选择用户确定并关闭
    function onUserConfirm()
    {   
    	userListGrid2.getSelectionModel().selectAll();
    	var store_tmp   ;
    		if(tmp_location.getValue() != 0)
    		{ 
    		 	store_tmp = Ext.getCmp(tmp_location.getValue()).items.items[3].getStore();
    		}
    		if(tmp_location.getValue()==0)
    		{
    		   store_tmp=exaExamRelativeGrid.getStore();
    		}
 		var beforaddCount = store_tmp.getCount();
 		beforaddCount+=1;
    	var records = userListGrid2.getSelectionModel().getSelections();
    	if(wintmp == 1)
    	{
	    	batchGrid.getStore().removeAll()
	        for( var i = 0; i < records.length; i ++ )
	        {
	       	    var r = userListGrid2.getSelectionModel().getSelections()[i];
	       	 	var ExaExamRelative = Ext.data.Record.create([{name:"id"},{name:"examId"},{name:"effectStart"},{name:"effectEnd"},{name:"userName"},{name:"userGroup"},{name:"examTime"},{name:"judgeUser"},{name:"userRealname"},{name:"arrangeGroup"},{name:"userEmail"},{name:"groupId"}]);
				var r2 = new ExaExamRelative({id:null,examId:r.data['id'],effectStart:user_BeginTime.getValue(),effectEnd:user_EndTime.getValue(),userName:r.data['username'],userGroup:r.data['deptCode'],examTime:0,judgeUser:null,userRealname:r.data['empName'],arrangeGroup:arrange_Group.getValue(),userEmail:r.data['userEmail'],groupId:r.data['groupId']});
				batchGrid.stopEditing();
				batchGrid.getStore().insert(0, r2);	  
	        }   
	         wintmp = 0 ;		
    	}
    	else
    	{   
	        for( var i = 0; i < records.length; i ++ )
	        {
	       	    var r = userListGrid2.getSelectionModel().getSelections()[i];
	       	 	var ExaExamRelative = Ext.data.Record.create([{name:"id"},{name:"examId"},{name:"effectStart"},{name:"effectEnd"},{name:"userName"},{name:"userGroup"},{name:"examTime"},{name:"judgeUser"},{name:"userRealname"},{name:"arrangeGroup"},{name:"userEmail"},{name:"groupId"}]);
				var r2 = new ExaExamRelative({id:null,examId:r.data['id'],effectStart:user_BeginTime.getValue(),effectEnd:user_EndTime.getValue(),userName:r.data['username'],userGroup:r.data['deptCode'],examTime:0,judgeUser:null,userRealname:r.data['empName'],arrangeGroup:arrange_Group.getValue(),userEmail:r.data['userEmail'],groupId:r.data['groupId']});
				var user_names=r.data['username'];
				var empName =r.data['empName'];
				if(tmp_location.getValue()==0)
				{
				 exaExamRelativeGrid.stopEditing();
				}
				else
				{
				 Ext.getCmp(tmp_location.getValue()).items.items[3].stopEditing();
				}
				if(beforaddCount==1)
				{
					store_tmp.insert(0, r2);
				}
				else
				{
					if(isExitCheck(user_names,store_tmp))
					{
						store_tmp.insert(0, r2);
					}
					else
					{    //V1.7 如果员工安排中用户重复，查看该用户是不是属于考试失败，如果是考试失败可以重新安排考试。
					     Ext.Ajax.request({params: {},
					      url: "../testarrange/checkRepeatUser.action?query.userName="+user_names+"&query.examId="+exaExamArrange_id.getValue()+"&query.exaType=23",
				          success: function(response) {
						  var resp = Ext.util.JSON.decode(response.responseText);
						  if (resp.status == "ok") {
							 Ext.Msg.alert('${app:i18n('prompt')}','${app:i18n('exam.isExit')}');   
						  } else {
						    Ext.MessageBox.confirm('${app:i18n('prompt')}','考生: "'+empName+'" 参考失败，你确定要该考生重考吗？', 
						    function(btn){
						       if(btn== 'yes'){
						          Ext.Ajax.request({params: {},
					                       url: "../testarrange/delInvalidAnswer.action?query.userName="+user_names+"&query.examId="+exaExamArrange_id.getValue()+"&query.exaType=23",
					                       success: function(response) {
						                   var resp = Ext.util.JSON.decode(response.responseText);
						                   if (resp.status == "ok") {
						                        var beforaddCount = store_tmp.getCount();
    	                                         for(var k = 0; k < beforaddCount; k++ )
		                                         {  
		                                        	if(store_tmp.data.items[k].data.userName==user_names)
		                                        	{
				                                        store_tmp.data.items[k].data.examTime=0;
			                                        	K=10000000000;
			                                          }
		                                          }
						                        Ext.MessageBox.alert('${app:i18n('prompt')}','考生: "'+empName+'" 添加成功');
						
						              } else {
							           Ext.MessageBox.alert('${app:i18n('prompt')}', '添加失败');
						              }
					          }
				              });
						       }
						    });
							
						   }
				        	}
			        	});
						
					}
				}
				
	        }
    	}
    	choosUserView.hide();
    }
    
    //是否已经存在该用户
    function isExitCheck(user_names,store_tmp)
    {
    	var tmp =true;
    	var beforaddCount = store_tmp.getCount();
    	for(var k = 0; k < beforaddCount; k++ )
		{  
			if(store_tmp.data.items[k].data.userName==user_names)
			{
				tmp=false;
				K=10000000000;
			}
		}	
		return tmp ;		
    }
    
    //用户树搜索
    var userGroupDeptCode='${deptCode}';
    deptCodeVar2.setValue(userGroupDeptCode);
    saveDeptCodeVar2.setValue(userGroupDeptCode);
    
     function selectDept(node) {
	    userGroupDeptCode=node.attributes.id;
	    deptCodeVar2.setValue(userGroupDeptCode);
	    saveDeptCodeVar2.setValue(userGroupDeptCode);
	   // alert(userGroupDeptCode);
	    if(node.attributes.id=='001'){
	    	if('${deptCode}'=='001'){
		    	disGrouptreeLoader.load(disGrouptreeLoaderNode, function() {
				 disGrouptreeLoaderNode.expand(false, true);
		       	});
		    }
	    }else{
	    	disGrouptreeLoader.load(disGrouptreeLoaderNode, function() {
				 disGrouptreeLoaderNode.expand(false, true);
		       	});
	    }
	    groupId='';
	    setUserListGridStore();
    }
    function setGroupParams(tp,node){	
    	//alert(userGroupDeptCode);
    	//deptCodeVar2.setValue(userGroupDeptCode);
    	//saveDeptCodeVar2.setValue(userGroupDeptCode);
    	tp.baseParams["queryDeptCode"]=userGroupDeptCode;
    	tp.baseParams["parentId"]=node.attributes.id;
    	//alert(node.attributes.id)
    	
    }
    var groupId='';
    function onSelectGroup(node){
    	 groupId=node.attributes.id;
    	userListGrid.getStore().proxy = new Ext.data.HttpProxy( {  
			  url : '../exagroupuser/findPageByExaGroupUser1.action' 
 		}); 
        userListGrid.getStore().baseParams = userQueryForm.getForm().getValues();
       
        userListGrid.getStore().baseParams["query.groupId"] = groupId;
        userListGrid.getStore().baseParams["limit"] = pagingBars.pageSize;
	    userListGrid.getStore().load();
    }
    function setTestpaperUrl(){
    	//deptCodeVar2.setValue(userGroupDeptCode);
    	//saveDeptCodeVar2.setValue(userGroupDeptCode);
    	userListGrid.getStore().proxy = new Ext.data.HttpProxy( {  
			  url : '../exagroupuser/findPageByExaGroupUser1.action' 
 		});  
    	userListGrid.getStore().baseParams = userQueryForm.getForm().getValues();
        userListGrid.getStore().baseParams["query.deptCode"] = userGroupDeptCode;
        userListGrid.getStore().baseParams["limit"] = pagingBars.pageSize;
	    userListGrid.getStore().load();
    }
    	function onAddExaExamRelative() {
			var ExaExamRelative = Ext.data.Record.create([{name:"id"},{name:"examId"},{name:"effectStart"},{name:"effectEnd"},{name:"userName"},{name:"userGroup"},{name:"examTime"},{name:"judgeUser"}]);
			var r = new ExaExamRelative({id:null,examId:null,effectStart:null,effectEnd:null,userName:null,userGroup:null,examTime:null,judgeUser:null});
			exaExamRelativeGrid.stopEditing();
			exaExamRelativeGrid.getStore().insert(0, r);
			exaExamRelativeGrid.startEditing(0, 0);
			exaExamRelativeGrid.getView().focusCell(0, 0);
		}
		function firstOnDeleteExaExamRelative(o){
			if(deptCodeTreeSelect=='${deptCode}'){
				onDeleteExaExamRelative(o);
			}
		}
		function onDeleteExaExamRelative(o) {
			 var record;
			if(o.location>0)
			{
			 record = Ext.getCmp(o.location).items.items[3].getSelectionModel().getSelected();
			 if (record != null) {
    			    if(record.data.id==null)
    			    {
                        Ext.getCmp(o.location).items.items[3].getStore().remove(record);
                        focusFunction(); 
    			    }
    			    else
    			    {   
        	            var change_timeBe = Ext.getCmp(o.location).items.items[1].getValue().format("Y-m-d H:i:s");
    			        var t_n = new Date();
                	    t_n = t_n.format("Y-m-d H:i:s");
                	    if(change_timeBe< t_n)
                	    {
    			           Ext.MessageBox.alert('${app:i18n('prompt')}','该批次已经到了考试时间，不允许删除人员');
                           return; 
    			        }
    			        else
    			        {
    			            Ext.getCmp(o.location).items.items[3].getStore().remove(record);
    			            focusFunction(); 
    			        }
    			    }
				}
			}
			else
			{
			  record = exaExamRelativeGrid.getSelectionModel().getSelected();
			  if (record != null) {
    			    if(record.data.id==null)
    			    {
                        exaExamRelativeGrid.getStore().remove(record);
                        focusFunction(); 
    			    }
    			    else
    			    {   
    			        var t_n_s = exaExamArrange_examBegin.getValue().format("Y-m-d H:i:s");
    			        var t_n = new Date();
                	    t_n = t_n.format("Y-m-d H:i:s");
                	    if(t_n_s< t_n)
                	    {
    			           Ext.MessageBox.alert('${app:i18n('prompt')}','该批次已经到了考试时间，不允许删除人员');
                           return; 
    			        }
    			        else
    			        {
    			           exaExamRelativeGrid.getStore().remove(record);
    			           focusFunction();
    			        }
    			    }
				}
			}
			
		}
		
		//批量修改用
		function onAddExaExamRelative2() {
			var ExaExamRelative = Ext.data.Record.create([{name:"id"},{name:"examId"},{name:"effectStart"},{name:"effectEnd"},{name:"userName"},{name:"userGroup"},{name:"examTime"},{name:"judgeUser"}]);
			var r = new ExaExamRelative({id:null,examId:null,effectStart:null,effectEnd:null,userName:null,userGroup:null,examTime:null,judgeUser:null});
			batchGrid.stopEditing();
			batchGrid.getStore().insert(0, r);
			batchGrid.startEditing(0, 0);
			batchGrid.getView().focusCell(0, 0);
		}

		function onDeleteExaExamRelative2() {
			var record = batchGrid.getSelectionModel().getSelected();
			if (record != null) {
				batchGrid.getStore().remove(record);
			}
		}
		function gridBeforeEdit(event) {
			event.grid.value = null;
			gridEventObj = event;
		}

		function gridAfterEdit(event) {
			if (event.grid.value) {
				event.record.set(event.field, event.grid.value);
				event.grid.value = null;
			}
		}
			
		function onBatch()
		{
			var records = gridView.getSelectionModel().getSelections();
				if(!(records.length>0))
				{
					Ext.MessageBox.alert('${app:i18n('prompt')}','请选择至少一条记录');
					return;	
				}
		 		else
		 		{
		 	     batchModify.show();
		 	     batch_testpaperUrl.disable();
				 batchfrom.getForm().reset();
		 		}
		}
		
 			function delRows()
	  {
	    var  arrCurt = userListGrid2.getSelectionModel().getSelections();
		if(arrCurt == ""){
			Ext.Msg.alert('${app:i18n('prompt')}','${app:i18n('tactics.error')}');
			return false;
		}
        for(var a=0; a < arrCurt.length;a++)
        {
			var count=parseInt(arrCurt[a].get('priorNo'));
			var n = userListGrid.getStore().getCount();
			var s = userListGrid2.getStore().getCount();
			var r = userListGrid2.getSelectionModel().getSelected();
			userListGrid2.getStore().remove(r);
			userListGrid.getStore().insert(n,r);
		}
	  }
	 //选定用户
      function selectedRows(){
      //	userListGrid.getSelectionModel().selectAll();
		var  arrCurt = userListGrid.getSelectionModel().getSelections();
		if(arrCurt == ""){
			Ext.Msg.alert('${app:i18n('prompt')}','${app:i18n('tactics.error')}');
			return false;
		}
			for( var i = 0; i < arrCurt.length; i ++ )
			{
	            var n = userListGrid2.getStore().getCount();
	            //alert(n);
				var r = userListGrid.getSelectionModel().getSelected();
	            userListGrid2.stopEditing();
	            var leng=0;
	            var username=r.data['username'];
	            //过滤重复的用户，提示用户不能添加重复用户
	            var item=userListGrid2.getStore();
	            if(isCheckName(username,n,item)){
	             userListGrid2.getStore().insert(n,r);
	             userListGrid.getStore().remove(r); 
	            }else{
	              	Ext.Msg.alert('${app:i18n('prompt')}',r.data['empName']+'${app:i18n('exaArray.userExist')}');
	            }
			         
			}
		} 
		function isCheckName(user_name,n,temp){
		      var bl=true;
		      
		      for( var i=0; i< n ;i++){
		        var user= temp.getAt(i).data.username;
		         if(user_name == user){
		            bl=false;
		            i=100000000;
		        }
		      }
		      return bl;
		}
	  //发送通知
	  function onSaveNotice()
	{
		if (isNewRecord == false) {
					setEditable(editView, true);
				}
			 
		    var ids='';
		 noticeForm.saveExamNotice();	
	}
	//批量修改 成功提示
		function showSaveSuccessInfoBatch(form,action)
		{
			if (action.result.status == "ok") {
				Ext.MessageBox.alert('${app:i18n('prompt')}', '${app:i18n('saveSuccess')}');				
				batchModify.hide();
				gridView.getStore().load();	
				onSearch();
			} else {
				Ext.MessageBox.alert('${app:i18n('saveFailure')}', action.result.status);			 
			}
		}
	//批量修改保存	
		function batchsave() {						 
				var records = gridView.getSelectionModel().getSelections();
				if(!(records.length>0))
				{
					Ext.MessageBox.alert('${app:i18n('prompt')}','${app:i18n('selectOneRecord')}');
					return;	
				}	
				var ids = '';				
				for(var i = 0; i < records.length; i++)  
				{
					ids += records[i].data.id + ',';
				}
				batch_testpaperUrl.enable();
				batch_ids.setValue(ids);		 
				batchfrom.batchModify();
		}	
		
			function getSlaveValue2(item) {
			if (item.isXType("editorgrid")) {
				var rs = new Array();
				var i = 0;
				item.getStore().each(function(r) { rs[i++] = r.data; });
				var json = item.id + '|' + Ext.util.JSON.encode(rs) + '_____JSON_____';
				batch_slaves.setValue(batch_slaves.getValue() + json);
			}
			if (item.items && item.items.getCount() > 0) {
				for(var i = 0; i < item.items.getCount(); i++) {
					getSlaveValue2(item.items.get(i));
				}
			}
		}	
			//查看试卷
		function showOperate(value, cellmeta, record, rowIndex, columnIndex, store){
			var showHtml = "<image title='查看试卷' style='cursor:hand;' onclick='doShowEaxmPaper()' src='${images}/preview.gif' style='width:12px;height:12px;'></image>&nbsp;&nbsp;";	
			return showHtml;
		}
		//显示试卷
		function doShowEaxmPaper(){
			if (gridView.getSelectionModel().getSelections().length != 1) {
				Ext.MessageBox.alert('${app:i18n('prompt')}','${app:i18n('selectOneRecord')}');
				return;
			}
			isNewRecord = false;
			record = gridView.getSelectionModel().getSelections()[0];
   			var createMethod = record.data['createMethod'];
   			var action=''; 
			if(createMethod==32){
			   	action ="../testpapermagr/doShowEaxmPaperUI.action?id="+record.data["testpaperId"];
			}
			if(createMethod==33){
				action ="../testpapermagr/doShowEaxmSuijiPaperUI.action?id="+record.data["testpaperId"];
			}
			window.parent.refreshPage('t', '试卷信息', '试卷信息', '', action, true);
			
		}
		function showOperationDiv(value, cellmeta, record, rowIndex, columnIndex, store){
			
			return "<image title='操作' style='cursor:hand;' onclick='showOperation(event,this,"+record.data.isDiscard+")' src='${images}/ltb_tle_o2.gif' style='width:22px;height:20px;'></image>";
			
		}
		function showOperation(event, obj,r){
		  //创建弹出菜单
          var pop=window.createPopup();
          
          //设置弹出菜单的内容
          pop.document.body.innerHTML = createFunctionHTML(obj,r);
          
          var rowObjs=pop.document.body.all[0].rows;
          //获得弹出菜单的行数
          var rowCount=rowObjs.length;
          //循环设置每行的属性
			var width = 140;

          for(var i=0;i< rowObjs.length;i++){
              
             //设置鼠标滑入该行时的效果
             rowObjs[i].cells[0].onmouseover=function(){
                   this.style.background="#99BBE8";
                  this.style.color="white";
             }
             //设置鼠标滑出该行时的效果
             rowObjs[i].cells[0].onmouseout=function(){
                 this.style.background="#F2F4F4";
                 this.style.color="black";

             }
       	   }
		   //屏蔽菜单的菜单
		   pop.document.oncontextmenu=function(){
				 return false;
		   }
		   //选择右键菜单的一项后，菜单隐藏

		   pop.document.onclick=function(){
				 pop.hide();
		   }
		   //显示菜单
		   pop.show(event.clientX-1,event.clientY,width,rowCount*25,document.body);
		   return true;
       }
       		// 根据行对象组合操作栏的HTML代码,用于弹出菜单
		// obj:列表行对象
	   //
	   function createFunctionHTML(obj,r){
	        
	   		var menuDiv = '<table width="100%" height="100%" cellspacing="0" cellpadding="0" style="border: 1px solid #4482D3; background: #F2F4F4;font-size: 9pt;">';
	   		
	   			//menuDiv += '<tr><td style="cursor:hand; height: 16px;padding: 2px;padding-left:5px;" align="left"   onclick="parent.onMove()" >'
	   			//menuDiv += '<img src="../pages/knowledgemgr/images/dg_btn_go.gif"   style="margin-bottom: -4px; margin-right:10px;width:16px;height:16px;"/>';
	            //menuDiv += '移动';    
	            //menuDiv += '</td></tr>';
				
				menuDiv += '<tr><td style="cursor:hand; height: 16px;padding: 2px;padding-left:5px;" align="left"  onclick="parent.doShowEaxmPaper()">'
	   			menuDiv += '<img src="${images}/preview.gif"   style="margin-bottom: -4px; margin-right:10px;width:16px;height:16px;"/>';
	            menuDiv += '查看试卷';    
	            menuDiv += '</td></tr>';

	          
	   		menuDiv += '</table>';
	   		return menuDiv;
		}
		
				//键盘事件
		function document.onkeydown(){
               if (event.keyCode==13)
               { 
                   event.returnValue=false; 
                   onSearch();
               } 
           }
 				//dir 
		function onResetDir()
		{
			paramValue_paramValue.setValue(null);
			paramValue_describe.setValue(null);
		}
        function  noticeSuccess(form, action)
        {
        	if (action.result.status == "ok") {
					Ext.MessageBox.alert('${app:i18n('prompt')}', '${app:i18n('sendNoticesuccess')}');			
					noticeView.hide();
			} 
			else if (action.result.status == "1")
			{
				Ext.MessageBox.alert('${app:i18n('prompt')}', '${app:i18n('emailStatus1')}');
				noticeView.hide();
			}
			else if(action.result.status == "2")
			{
			 Ext.MessageBox.alert('${app:i18n('prompt')}', '${app:i18n('emailStatus2')}');
			 noticeView.hide();
			}
			else
			{
				Ext.MessageBox.alert('${app:i18n('saveFailure')}', action.result.status);
				if (isNewRecord == false) {
					setEditable(editView, false);
				}	
			}
		}
		function KK(tp,node)
       {	//alert('KK   '+node.attributes.id);
       	  tp.baseParams["depeCodes"]=node.attributes.id;
       }
       function showT()
       {   
	       if(stuIndex>0)
	       {
	        for(var k=stuIndex;k>0;k--)
	        {
	         delStu(k);
	        }
	       }
       }
       function timeChanged()
       {	
			var isDateTimeRight = true;
	        var tmp_count222 =exaExamRelativeGrid.getStore().getCount();
			if(tmp_count222>0)
			{   
			    
				if(exaExamArrange_examBegin.getValue()==''||exaExamArrange_examEffectend.getValue()=='')
				{
				 Ext.Msg.alert('提示','请先确定考试的时间范围');
				 isDateTimeRight=false;	
				}
				else
				{   
				    flag=false;
                    for(var jj =0 ; jj< tmp_count222;jj++)
    				{
    				    if(exaExamRelativeGrid.getStore().getAt(jj).data.id!=null)
        				{
        				    flag=true;
        				    break;
        				}
    				} 
                    if(!flag)
                    {
                        var nowValue = Ext.getCmp(oid).getValue().format("Y-m-d H:i:s");
			  	        var t_n = new Date(); 
			      	    t_n = t_n.format("Y-m-d H:i:s");
                        if( nowValue< t_n)
                        {
                             Ext.Msg.alert('提示','开始时间必须大于当前时间');
                	         isDateTimeRight=false;
                        }
                    }
                    
				 if(exaExamArrange_examBegin.getValue()>=exaExamArrange_examEffectend.getValue())
				 {
				 	Ext.Msg.alert('提示','结束时间必须大于开始时间');
				 	isDateTimeRight=false;	
				 }
				 else
				 {	
				   for(var jj =0 ; jj< tmp_count222;jj++)
					 {
						exaExamRelativeGrid.getStore().getAt(jj).data.effectStart=exaExamArrange_examBegin.getValue();
						exaExamRelativeGrid.getStore().getAt(jj).data.effectEnd=exaExamArrange_examEffectend.getValue();
						//exaExamRelativeGrid.getStore().getAt(jj).commit();
					 }
				 }
				}
			}
			else
			{
			     Ext.Msg.alert('提示','请至少选择一位人员');
			     isDateTimeRight=false;	
			}
			return isDateTimeRight;
        }
       function timeChanged2()
       {
		var isDateTimeRight = true;
        var tmp_location1 = stuIndex;
        if(tmp_location1>0)
        {
         for(var kl =1;kl<=tmp_location1;kl++)
         {
        	var tc ="exaExamRelativeGrid"+kl;
        	var change_timeBe = Ext.getCmp(kl).items.items[1].getValue();
       	    var change_timeEd = Ext.getCmp(kl).items.items[2].getValue();
       	    var store_change = Ext.getCmp(kl).items.items[3].getStore();
       	    var store_changeCount =store_change.getCount();
       	    if(store_changeCount>0)
       	    {
       	      if(change_timeBe==''||change_timeEd=='')
				{
				 Ext.Msg.alert('提示','请先确定考试的时间范围');
				 isDateTimeRight=false;
				 break;
				}
				else
				{
				   var flag=false;
                   for(var jj =0 ; jj< store_changeCount;jj++)
    				{
    				    if(store_change.getAt(jj).data.id!=null)
        				{
        				    flag=true;
        				    break;
        				}
    				} 
                    if(!flag)
                    {
                        var nowValue = Ext.getCmp(oid).getValue().format("Y-m-d H:i:s");
			  	        var t_n = new Date(); 
			      	    t_n = t_n.format("Y-m-d H:i:s");
                        if( nowValue< t_n)
                        {
                             Ext.Msg.alert('提示','开始时间必须大于当前时间');
                	         isDateTimeRight=false;
                        }
                    }
				    
				 if(change_timeBe>=change_timeEd)
				 {
				 	Ext.Msg.alert('提示','结束时间必须大于开始时间');
				 	isDateTimeRight=false;
					 break;
				 }
				 else
				 {
				   for(var jj =0 ; jj< store_changeCount;jj++)
				  {
				    store_change.getAt(jj).data.effectStart=change_timeBe;
	       	     	store_change.getAt(jj).data.effectEnd=change_timeEd;
					//store_change.getAt(jj).commit();
	       	      }
				 }
       	      }
         }
         else
		{
		     Ext.Msg.alert('提示','请至少选择一位人员');
		     isDateTimeRight=false;	
		     break;
		}
        }
       }
       return isDateTimeRight;
       }
       function hideT()
        {
         paramValue_parentId.enable();	
        }
        
     function rootselected1()
	{
	  query_testpaperUrl2.setValue(null);
	  onSearchPaper();
	}  
	function onQueryEmail()
	{
	 window.parent.refreshPage('queryEamiStatus','查看发送邮件状态','发送邮件状态',null,'../sendemaistatus/examEmai.action',true);
	}
	function showNoticeFalure (form, action) {
		if (action.failureType == "client") {
			Ext.MessageBox.alert('${app:i18n('prompt')}', '${app:i18n('validateError')}');
		} else {
			Ext.MessageBox.alert('${app:i18n('prompt')}', '${app:i18n('saveFailure')}');
		}
		if (isNewRecord == false) {
			setEditable(editView, false);
		}
	}
	function resetTree()
	{
	 tmp_load.root.reload();
	}
	function initRowIndex(t,p,s ,k,l,m)
	{
	 var t= t;
	 var p =p;
	 var s= s;
	 var k = k;
	 var l = l;
	 var m = m;
	 return exaExamRelativeGrid.getStore().getCount() ;
	}
	function initRowIndex1()
	{

	 var c = this.name;
	 var areaArray = c.split("|"); 
	 var tmpLenth =areaArray.length;
	 if(tmpLenth==2)
	 {
		return Ext.getCmp(areaArray[1]).items.items[3].getStore().getCount();
	 }
	}
	function typechange(t,p,o,r,s)
		{	
			var t = t;
			var p = p;
			var typeBeforeChange=t.lastSelectionText;
			var typeBeforeChangeValue=t.value;
			var typeAfterChangeValue=p.data.paramId;
			var typeAfterChange=p.data.paramValue;
			var o = o;
			var r = r;
			var s = s;
			if(exaExamArrange_id.getValue().length>0)
			{
			    if(typeBeforeChange!=null)
    			{    
                    if(min_Date.getValue()!="")
                    {
                      var t_n = new Date();
                      t_n = t_n.format("Y-m-d H:i:s");
                      if(min_Date.getValue()< t_n)
                      {
                        Ext.Msg.alert('提示','该安排已经到了考试时间，不允许修改');
                        return false;
                      }
                    }
    			} 
			}
		}
	function isOverNewDate(date)
	{   
	    var tover = true;
	    var t_n = new Date();
	    t_n = t_n.format("Y-m-d H:i:s");
	    if(date< t_n)
	    {
	        Ext.Msg.alert('提示','该安排已经到了考试时间，不允许修改');
	        tover=false;
	        return;
	    }
	}
	var isPass=true;
	Ext.message = function(){
    var msgCt;
    function createBox(t, s){
        return ['<div class="msg">',
                '<div class="x-box-tl"><div class="x-box-tr"><div class="x-box-tc"></div></div></div>',
                '<div class="x-box-ml"><div class="x-box-mr"><div class="x-box-mc"><h3>', t, '</h3>', s, '</div></div></div>',
                '<div class="x-box-bl"><div class="x-box-br"><div class="x-box-bc"></div></div></div>',
                '</div>'].join('');
    }
    return {
        msg : function(title, format){
            if(!msgCt){
                msgCt = Ext.DomHelper.insertFirst(document.body, {id:'msg-div'}, true);
            }
            msgCt.alignTo(document, 't-t');
            var s = String.format.apply(String, Array.prototype.slice.call(arguments, 1));
            var m = Ext.DomHelper.append(msgCt, {html:createBox(title, s)}, true);
            m.slideIn('t').pause(5).ghost("t", {remove:true});
        }
    };
}();
	function DateChange(o,p,s)
	{   
	    //id用来获取控件
	    var oid = o.getId();
	    var  o = o.value;
	    var id = this.getId();
	    var s =s ;
	    //新增安排的时候校验
	    if(isAddOrEdit==0)
	    {
	    	var nowValue = Ext.getCmp(oid).getValue().format("Y-m-d H:i:s");
	    	//结束时间的根据开始时间来决定是否修改
   	        if(oid.indexOf("examEffectend")>-1)
   	        {
   	            var toid=oid.replace("examEffectend","examBegin");
   	            var beginDate = Ext.getCmp(toid).getValue().format("Y-m-d H:i:s");
   	            if(nowValue <= beginDate){
   	            	isPass=false;
	                 Ext.getCmp(oid).setValue(null); 
	                 Ext.Msg.alert('提示','结束时间必须大于开始时间');
	                 isPass=true;
	                 Ext.getCmp(oid).clearInvalid();
	    	         return;
   	            }else
	            {
	                isPass=true;  
	            }
   	        }else{
	  	        var t_n = new Date(); 
	      	    t_n = t_n.format("Y-m-d H:i:s");
	            if( nowValue< t_n)
	            {
	                 isPass=false;
	                 Ext.getCmp(oid).setValue(null); 
	                 Ext.Msg.alert('提示','开始时间必须大于当前时间');
	                 isPass=true;
	                 Ext.getCmp(oid).clearInvalid();
	    	         return;  
	            }
	            else
	            {
	                isPass=true;  
	            }
   	        }
            
	    }
	    //编辑的时候的校验
	    else
	    {
	        //初选的值不为空
	          var checkResult = true;
	        if(oid.indexOf("begintime")>-1||oid.indexOf("endtime")>-1)
	        {
	             var i = oid.split("time")[1];
            	 var tmp_count222 = Ext.getCmp(i).items.items[3].getStore().getCount();
        		 if (tmp_count222>0)
        		 {   
        		     var flag= false;
        		     for(var jj =0 ; jj< tmp_count222;jj++)
        			 {
        				if(Ext.getCmp(i).items.items[3].getStore().getAt(jj).data.id!=null)
        				{
        				    flag=true;
        				    checkResult = true;
        				    break;
        				}
        				 
        			 }
        			 if(flag)
        			 {
        			     checkResult = true;
        			 }
        			 else
        			 {
        			    checkResult = false;
        			 }
        		}
        		else
        		{
        	        checkResult = false;
        		}
	        }
	        if(s!=""&&checkResult)
    	    {   
    	        s= s.format("Y-m-d H:i:s");
    	        var ts = s; 
    	        var t_n = new Date(); 
    	        t_n = t_n.format("Y-m-d H:i:s");
    	        //结束时间的根据开始时间来决定是否修改
    	        if(oid.indexOf("examEffectend")>-1)
    	        {
    	            var toid=oid.replace("examEffectend","examBegin");
    	            s=Ext.getCmp(toid).getValue().format("Y-m-d H:i:s");
    	        }
    	        if(oid.indexOf("endtime")>-1)
    	        {
    	            var toid=oid.replace("endtime","begintime");
    	            s=Ext.getCmp(toid).getValue().format("Y-m-d H:i:s");
    	        }
    	        //当前值小于当前时间
        	    if(s< t_n)
        	    {
        	        isPass=false;
        	        Ext.getCmp(oid).setValue(ts); 
        	        Ext.Msg.alert('提示','您修改了已经开始的考试批次时间，系统将重置该批次的时间。');
        	        Ext.getCmp(oid).clearInvalid() ; 
        	        return;  
    	        }
        	    else
                {   
                    var nowCheck= Ext.getCmp(oid).getValue();
            	    if(nowCheck!="")
            	    {
            	        nowCheck= nowCheck.format("Y-m-d H:i:s");
            	        var t_n = new Date(); 
                	    t_n = t_n.format("Y-m-d H:i:s");
                	    if(nowCheck< t_n)
                	    {
                	      Ext.getCmp(oid).setValue(ts); 
                	      Ext.Msg.alert('提示','开始时间必须大于当前时间');
                	      return;   
                	    }
            	    }
                    isPass=true;  
                }
    	    }
	    }
	    isPass=true; 
	}
	
	function nochange()
	{
	    if (result == 'yes') 
	    {
	        isPass=true;  
        }	    
	}  
	 
	function ck()
	{
	     if(isPass==null||isPass==false)
	     {
	        return false;
	     }
	     else
	     {
	       return true;
	     }
	} 
	
	function btnvalidation()
	{   
	    selectedPaper.getSelectionModel().selectAll();
    	var records = selectedPaper.getSelectionModel().getSelections();
    	if (records.length < 1) {
    	    focusFunction();
    		Ext.MessageBox.alert('${app:i18n('prompt')}', '${app:i18n('pleaseChooseApaper')}');
    		return;
    	}
    	else if(!timeChanged())
    	{
    	    return;
    	}
        else if(!timeChanged2())
        {
            return;
        }
        
    
	    btnSaveFlag=true;
        btnSave.enable(); 
	}
	
	function focusFunction()
	{
	    if(isAddOrEdit!=0)
	    {
	        btnSaveFlag=false;
	        btnSave.disable();
	    }
	}
	
		 //用户树搜索
	//alert(deptCodeTreeSelect+ "   "+'${deptCode}');	 
    function selectDept1(node) {
    
    	if(deptCodeTreeSelect!=node.attributes.id){
		  	gridView.getStore().removeAll();
		 }
		
       deptCodeTreeSelect=node.attributes.id;
	   query_testpaperUrl.setValue(null);
	   queryCreateDept.setValue(deptCodeTreeSelect);
	   hideButton(deptCodeTreeSelect);
	   distree1.load(distreeLoaderNode, function() {
		 distreeLoaderNode.expand(false, true);
       });
    }
   function hideButton(deptCode){
    	if(deptCode!='${deptCode}'){
			if('admin'=='${currUser}'){
			 btnAdd.hide();
			 btnEdit.hide() ;
			 btnDelete.show();
			 btnbatch.hide();
			 btnView.show();
			 btnNotice.hide();
			 btnAddDir.hide();
			 btnEditDir.hide();
			 btnDeleteDir.hide();
			}else{
	        btnAdd.hide();
			btnEdit.hide() ;
			btnDelete.hide();
			btnbatch.hide();
			btnView.show();
			btnNotice.hide();
			btnAddDir.hide();
			btnEditDir.hide();
			btnDeleteDir.hide();
			}
        }else{
        	btnView.hide();
        	 btnAdd.show();
			btnEdit.show() ;
			btnDelete.show();
			btnbatch.show();
			btnNotice.show();
			btnAddDir.show();
			btnEditDir.show();
			btnDeleteDir.show();
        }
    }
    function KK1(tp,node)
    {	
        tp.baseParams["depeCodes"]=node.attributes.id;
        //deptCodeTreeSelect=node.attributes.id;
        //alert(deptCodeTreeSelect);
    }
    
    function setParams(tp,node){
    	//alert(deptCodeTreeSelect);
    	tp.baseParams["deptCode"]=deptCodeTreeSelect;
    }
    function rootselected2()
	{
		  if(deptCodeTreeSelect!='001'){
		  	gridView.getStore().removeAll();
		  }
		  deptCodeTreeSelect='001';
		  queryCreateDept.setValue(deptCodeTreeSelect);
		  query_testpaperUrl.setValue(null);
		  hideButton(deptCodeTreeSelect);
		  
		  distree1.load(distreeLoaderNode, function() {
			 distreeLoaderNode.expand(false, true);
      	 });
	}
	function setUserListGridStore(){
		userListGrid.getStore().proxy = new Ext.data.HttpProxy( {  
			  url : '../queryUserByDept/findPageByGroupUserbyDeptCode.action' 
 		});  
		 
		 userListGrid.getStore().baseParams = userQueryForm.getForm().getValues();
	     userListGrid.getStore().baseParams["limit"] = pagingBars.pageSize;
	     userListGrid.getStore().load();
	}
	function rootGroupSelected2()
	{
		  if(userGroupDeptCode!='001'){
		  	gridView.getStore().removeAll();
		  }
		  userGroupDeptCode='001';
		  if('001'=='${deptCode}'){
		  deptCodeVar2.setValue(userGroupDeptCode);
		  saveDeptCodeVar2.setValue(userGroupDeptCode);
		  }
		 disGrouptreeLoader.load(disGrouptreeLoaderNode, function() {
			 disGrouptreeLoaderNode.expand(false, true);
      	 });
      	 
      	 groupId='';
      	  setUserListGridStore();
	}
	function afterShowEditView(comp){
		//alert(editView.title);
		//alert('${app:i18n("exaTestPaperInfo.onView")}');
		if(editView.title=='查看考试安排')
		{
								
			btnvalidation.disable();
			//btnDeleteExaExamRelative.disable();	
			//add.disable();		
			
		}else{
			btnvalidation.enable();
			//btnDeleteExaExamRelative.enable();	
			//add.enable();
		}
	}
	var paperDeptSelect='001';
	function selectPaperDept(node){
	   //alert(paperDeptSelect);
	   paperDeptSelect=node.attributes.id;
	   queryPaperCreateDept.setValue(paperDeptSelect);
	   query_testpaperUrl2.setValue(null);
	   testPaperTree.load(testPaperTreeNode, function() {
		 testPaperTreeNode.expand(false, true);
       });
	}
	function setPaperParams(tp,node){
    	tp.baseParams["deptCode"]=paperDeptSelect;
    }
    queryPaperCreateDept.setValue('001');
	function  paperRootselected2(){
		if(paperDeptSelect!='001'){
		  	gridView.getStore().removeAll();
		}
		  paperDeptSelect='001';
		  queryPaperCreateDept.setValue(paperDeptSelect);
		  query_testpaperUrl2.setValue(null);
		  testPaperTree.load(testPaperTreeNode, function() {
			 testPaperTreeNode.expand(false, true);
	       });
	}
	
	function setDeptParams(tp,node){
    	
    	tp.baseParams["deptCode"]='${deptCode}' ;
     }
     
     function firstAddStu(){
     	if(editView.title=='查看考试安排')
		{
				
		}else{
			addStu();
		}
     
     }
	</ext:script>
</ext:ui>
