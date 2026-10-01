Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCC7389460;
	Thu,  1 Oct 2026 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869868; cv=fail; b=QWt93B5OS+wOomAZOoUSUrw/xRLnLa3M1nBCb4LTEayn6q57b8kuW49VED7p4AzJDUbFatOOp20ILPjXmwvddv7M5vLU1+RrH06ci9Ag1Z0amzv/LQyDxHKGOGQdxJPAfa0qgQ2aM/wu29G3umwFsNeAU2On++Kz/tlHiMzDH5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869868; c=relaxed/simple;
	bh=78+h8KeYCgiQg9Fjo6wdmq/WlOcVOXzO1ysS9J82u1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=S8s66wwb0tyTIvzxoCYDXW/Z4tZoeRiEd4UqJCYk4s+BM14DM6CExgtthGZcqEsFrElj1rpjf3A85XMulyRKxrvw6vvDHIYLUT1569CCTclsh/BrJbpW47TrPHUA3zqL3fgrjWOvG+SQ47oyhVfKi/U9XHJj10ezzy1Wx2RXAvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=QigGW0kE; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=DWUAn/nS; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="QigGW0kE";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="DWUAn/nS"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DkOLt2097849;
	Thu, 1 Oct 2026 10:51:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=TuXmF1DQwEy26wm6ceNGi3dY9dJNWSwuY+YXLGFNM
	CA=; b=QigGW0kEhD47ahkJl+sZRMMil9KFeKDrEpHHwerzDBmxJTXM90wIqFAAL
	A+VjVVMwj6l0xFr7rlU4JZ9tLOFimS5cu5WtE9wbc3od9fW7d1zqspKkGQ9TI/CG
	dL3cYfByK8tJywuRSX3CvhI3kDLyE+0nv7W52CnAZ3wu5QL+pymEg9M7IsJO0kUp
	uThVP2+pYHw53ZzDhU39Xu2xdq/BttoSIXLTB7/dJz8nvx/E2KiYXxO6ZksmkwnU
	D/pvfcRIVSJ1PZEGUMjOqVJU1zzyb3x1tcgSrE3TK1EYW35vBYDvikufWBtXurug
	x0IjOYqQ3bCHjiUMCB5K8UBywkxtg==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h1eurcaab-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:51:01 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9h3ep6Q4IfXLEP73iug+L2v0a7+SRtv0u7Mdv4i7L3YLDu4sHnpEwTyYbAsqjbDUhLArnGfcGqEZC9DGPKMPNpYnCPgYiyveB1gifL6auXIhpHYSQKiE2evaTmfQ9GqqiRlC7bqqcImbzBbgn/KFjsMNn7YpyoyzBVMTwP4Kz2a2qLLdbMbbxLzhvV5gXxSn4BHWE/0a0vwwgZgucTF71+glrnrWVvEjngSRSO+DjmPLTtMHSScZK7Ta4FPT3hE3xrOq5PQurjRVHIINNu3YbY6PE+P6RzjwG79V/NR0ij3cjY0fiOK1iwyFcqbwKGEjUe2WftfFAWqA+I0Doigmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuXmF1DQwEy26wm6ceNGi3dY9dJNWSwuY+YXLGFNMCA=;
 b=It0QaAaSk9ca2ztC/B0LfMcPCk+OoKpRfL9ntWJg/SHov6QHNaPoB4MjuXeRvvq076zCgyXNKvfRQDzF99mPLojdY+1dnt4+9XMHPR3vZSDPxJTfX31aCeJiJJZQka2UfjpNStA4rF2uKEe2LyLkksw7jeOc6rV6eDdO2LLVFDtuVY8yWOvDXmhFsnn+yoYctlV3h5EN6XPRqqzFIo4Y/7Iq1XT/7w9xT5xv+DenGvGUZu+UQd7SuSlddTMrXEKda/tzIcdZxI/yXAPUjNOyxYQnZJK7GAok7iAoIWVE2lnqpOoshUIkYuXBBtWot5K+lEFDG1rhVllhsY5M/MNYKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuXmF1DQwEy26wm6ceNGi3dY9dJNWSwuY+YXLGFNMCA=;
 b=DWUAn/nSMWxKqjH3lTc0yYnYMz+ttSsRtcVitrnAqMHJniwt+IvOFWD9Sz1UTxhVb9HwZ/3SGPeeaspP/XCyRyNAs8W2zUV9KJMQ+OebfkR5YDwVXMkVPWG0zGAy7mfdRWErfxH564NJqJLLTX0Lg3bYMcCyAGaJbosnGUxd19E=
Received: from BL1PR13CA0186.namprd13.prod.outlook.com (2603:10b6:208:2be::11)
 by DS4PPFAE15A2261.namprd10.prod.outlook.com (2603:10b6:f:fc00::d3f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Thu, 1 Oct
 2026 15:50:55 +0000
Received: from BN7PEPF000000AB.namprd05.prod.outlook.com
 (2603:10b6:208:2be:cafe::68) by BL1PR13CA0186.outlook.office365.com
 (2603:10b6:208:2be::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Thu, 1
 Oct 2026 15:50:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN7PEPF000000AB.mail.protection.outlook.com (10.167.245.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:50:53 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 1 Oct
 2026 10:50:35 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 1 Oct
 2026 10:50:35 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 1 Oct 2026 10:50:35 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 691FoZWO2219384;
	Thu, 1 Oct 2026 10:50:35 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Thu, 1 Oct 2026 10:50:33 -0500
Subject: [PATCH v3 1/2] dt-bindings: input: gpio-keys: add pinctrl states
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261001-upstream-gpio-wakeup-v3-1-6f3bcde367a3@ti.com>
References: <20261001-upstream-gpio-wakeup-v3-0-6f3bcde367a3@ti.com>
In-Reply-To: <20261001-upstream-gpio-wakeup-v3-0-6f3bcde367a3@ti.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <msp@baylibre.com>, <s-kochidanadu@ti.com>, <a-kaur@ti.com>,
        <s-tripathi1@ti.com>, <vishalm@ti.com>, <k-willis@ti.com>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790869835; l=2049;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=78+h8KeYCgiQg9Fjo6wdmq/WlOcVOXzO1ysS9J82u1s=;
 b=6uyrVLh6kCVlIIZm2DzXLYOMed+ZnrUQupb5ZP1s6/4pQ28Rs2FTUMpWhIZVleNiP4sNtfmmr
 hsCD1QKLe2hAtGZpxueP/vjsV53QRoM49pwirbLkwSMhsxUZ/K4KvDY
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000AB:EE_|DS4PPFAE15A2261:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5c4ca6-82ef-4079-19a2-08df1fd3c698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|10067099003|6133799003|260925021911599003|260925021311599003|56012099006|260925022911599003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EfckRoXi4CV0fiahTIwCVqIWX0LokLgrhZKHTY3Do0KkLgPJL24zntSYpwAOIkGeo9UaAkvNQKRpVWYI0Lf41kHY8wAMgNU3iRiPClQgmYJ1hBUZ7tQLvRoEJxhWkGXD58Q0Q8k204xijqPX3ABTGzMvX2mG+erUhnARLyoCO3H52tTnmj3dshu8yZ1aQN3S4DdPWxtcRU2oahMMtbj+Rb93Mw2PpTscJKWshFlrnb9Gjo+CszgcKGrjbCIR9sXnx24K5NqbP0w0ZJyYk3/QsKv3P5ErA0lgRQPphHHaPi+WlU7VMh/EmuqLYkfncrX2mg/0oramG9pwn414jwTpO65DTKAUo9XqZWLDVvszOa+2SPwpz2dKdQ+fEbQyGSh6+ICiMzDDCZ3ITqzTnPDBQUFhyt0lG5w6at9rn3bgKOu/+rgNlNFt3LjGCMirj+DYIUlpCX51dW5NEQ4sPvlbKgYe6xgWdguN8MMZb7HnoJJXILfknocKTrqktIXrIv1YwD3Bt0QSQ+6LEtOrQSEJAZ9IQuQ8S6pUV9LhVRnBjUM4JLk0UJwRscmk4rY1mWaaI8W+dBl3ZedfOogbDnj+fw1mvr0J1T/qu5v3ETMmzeE5BQ2dko3QG1WEzb+TjswqXAxpmh/UrASP4fskLTtmwsW2dxOjn5xzP4k+odmm1IaAEXQ55n2uJmM4/avy6VUR9qujWBY/RSK6JmP3Kh2T2A==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(10067099003)(6133799003)(260925021911599003)(260925021311599003)(56012099006)(260925022911599003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HXvtz2Dc2BLT3tuYnQ3i1rEGerLMqEuCosULJbGgg6FWFA++bTM9zwe6BrTWLZWVFA3bZ4s3NHUyKF/4D+xFynYV26r0jBWh7+4vzhbB4L1nZUrmNlwWGniEoGi7fKLyuI5z3+iZIvTG0o7RNX5ZMlENLVvWCmcVAt4OKUjGARIzAqjSsFY5uEdVlR1+V+jmEUllgXKxbnC/029hGbPTZPzpRzMBiU50aBudt4TkQt0YfsiLZhVqI4FnJiDQzgb9WICiYXfg7u7sw3dTgFVhluFLxx4Zc+4bjMFWC+4gEScfQY3OHdBEoS/Wkmbq0KVxRX8pBJlpFZ0KfBWek666rFq5ARFLcN/KHNmpXGUixqLQiDZvuP2ecm9qgsK44/6gpGsANe+CcV4lghH+MVIIf55nxPLH2exCjoCLGrTeF8GvYtn9YG65I3DUZwjJ3uGh
X-Exchange-RoutingPolicyChecked:
	5lD7Uo4nzdTNffZ7wpfGi68cveR3lV3OMs7WQeSjckXnzpxTQwcABPHPGwwkiYcMo7UVrCwTeeJ2Kom777Nhsk1nZpF+sdmE4oVvvQXq5ahiNI6/pl5Hb8Ix7QpjLlgh9wHj3NT3OxNbb//inu0OS5Wl0YsSINXCtLypBXP3TSAdff5iM6Kksj4VgYO31xvqppm2JKXGOeJ5HvUqmMxbSCH5OqrvVGzfl7IF12DKPfWGNFSqlh5k4mxiPTDuC61JhqTnv0vl4aopwfNAbllvQ8hIKgds8S5sMgEi77RMNyhjuijyxVnbGiXdJjQqKmkLikMf744zsiIZeto4aggOQw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:50:53.9115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5c4ca6-82ef-4079-19a2-08df1fd3c698
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000AB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFAE15A2261
X-Proofpoint-GUID: PPzR_7YR0b5zgIWxclCCf752YemtqV-4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2MiBTYWx0ZWRfX13iBiqZsJ3ew
 50vGV6BeLdkoTD+cVDFRas6eryYMPkK6m+A7w5efgkBtp6SGEJY+bXtL8l5whSgU4bJH18isL6k
 a3iErmENENWBNd4454esWlI78m4xBxBjdxwjSezgDWmAEv0UhI3oedmiG6R1CPKNxgtjXyapIdB
 ltdBRWYdtEwXgfgL3Je5gofRsq2GgsHXJdUuX5NxuJIynfVCCBex2lsMkc2l211BMsM8yB5k31g
 jBHF896l4xUI/WeCnKb67FIPpvWYdw7+E89yF4zNwhBCSur6WZnD4rNAjAUFdDzvI6hwvdKXQuP
 q3aRu5nAAYKS7eFY3SivOallKPivYHggwM3dfnDRuGTIGjJW+qggBMcQdUrF5u+IZpe4p9CoDd/
 hKXPdcrV6iOjz2Nut8WprM5ihSrlSIgIItupitqMEtNAWGEhPF3RVdLMxQfKp0SLparZOSZDY5x
 6bcwj/gEWOY18tbQGsw==
X-Authority-Analysis: v=2.4 cv=KvzYSmWN c=1 sm=1 tr=0 ts=6abe8165 cx=c_pps
 a=QJKYq+wIgDf6wDJMVANEtw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=sVqJxYME3hYzk5PecwcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PPzR_7YR0b5zgIWxclCCf752YemtqV-4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2MiBTYWx0ZWRfX98iyrV9e5TxB
 IN3hwe++FV+bN0n1s4T2KiMa4v16rKXKiSxdF+U1U+6O5sENyyjNPi/7YlO8fmNHFNBZvEgK+i2
 HSxvsJChDxMSr+JIoAVf3DZAFnnnUIg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010062

Document pinctrl properties on the gpio-keys device node. The default
pinctrl state describes the default pin configuration. The wakeup state
configures pins to be able to wakeup the system from suspend if GPIO is a
wakeup source.

The pinctrl sleep state is not defined here despite being used to configure
pins for system suspend to save power. It is not defined since no
gpio-key device tree nodes utilize it. If the sleep state was added, a
device could use both the wakeup state and sleep state. The sleep state
would be entered upon suspend when wakeup is disabled for the device,
whereas the wakeup state would be entered upon suspend if wakeup is enabled
for the device. For now only the wakeup state is defined since it is
used specifically to enable pin configurations that can wakeup the
system from suspend.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 Documentation/devicetree/bindings/input/gpio-keys.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
index cc78c2152921308fe0cad3e29ca78a5fad08f066..a0712fba45845e42ca63489354e0cae87de2143f 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
+++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
@@ -22,6 +22,22 @@ properties:
 
   poll-interval: true
 
+  pinctrl-0:
+    description: Default pinctrl state
+
+  pinctrl-1:
+    description: Wakeup pinctrl state
+
+  pinctrl-names:
+    description:
+      When present should contain at least "default" describing the default pin
+      states. The "wakeup" state describes the pin state used to wakeup the system
+      when wakeup is enabled and the system is suspended.
+    minItems: 1
+    items:
+      - const: default
+      - const: wakeup
+
 patternProperties:
   "^(button|event|key|switch|(button|event|key|switch)-[a-z0-9-]+|[a-z0-9-]+-(button|event|key|switch))$":
     $ref: input.yaml#

-- 
2.34.1

