Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF7415530C;
	Tue, 17 Mar 2026 01:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773712299; cv=fail; b=Eb5Ajev51SRqfwyG8K5YtssWDN350JkuLcK5hwEeJtXMYz1GcIPm67j6x7vqBz1eFv5zMjHnUtsItXeBLuQQ4P1VR2eCxqFR5jq0RH5G/1Tjm5KeblXZA0buKnLDjg3UlZA3EkmOl3C5WFAf7wytgMLL9PZ7PFa4kFRCauXqgbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773712299; c=relaxed/simple;
	bh=AL5eKLTwOLaf1HOYNFLLpx7d7bVqFu5uhhbJgi6f58c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c33hxcZszkZvTl6TmgrApBpNwpDYIgvuOR5vRMpxjWb3YUn2zbihR5giYj3wTOUX0SjdjOsrlCu1WVDmPC0bMGQHTyZpCLw6BGiQSyxsxhtRGkohnzSOctdSzqgal9CIXyGyIGazEI2d3GA2tZsU1bAC464oN2KenlUzTEeVRUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=J7SADHLc; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="J7SADHLc"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GLhViM1059926;
	Mon, 16 Mar 2026 21:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=AL5eK
	LTwOLaf1HOYNFLLpx7d7bVqFu5uhhbJgi6f58c=; b=J7SADHLcfVKTrW1sup0nD
	QvQ43nl6zNSZi89NNjWJ7jns+apL/geiYKuKsEmLFBBOCZ9inDhmliNVz9bwCRUW
	Gm2dTSLRIJLUcbKf38m+z2XT2L1WewpR99AgB3ejiVqA8zZV0cdOMrgdKRpQytC+
	+90wV3u949ZVoFIn/+pkHys4mVn+1ZnSFLC4hRZhMjluXhfO293wfpgm2qOl63OC
	YZL1bTEqFMpmHN8ybtom+J2Qz1QPqtli2L4IeP1gd65WD8E8xb5GKkMLzarg7BNU
	q2tf900fN6KMdzWh7TSKjZZwh0PU+SN+TtkU9SikJocq+e+GnVZnYyYOmnImyEy8
	g==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cwsqf5mg4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 21:51:33 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIH2+5yEKE6tN2LSvpANBq3O4ciwIZKLUeGjORj/An9tEcb3ACPKEC69rsyW18VVVISPxoO6hwuPQpseO1Yuly0Z7Eu5t7EPYEqg6ck/h/Sk/NGS3I0FcpGwzbR4LTRmraeefJ70kwnf2cg4FRWvWFokgKhG3Qd48haFYZ/LwJoBovEfjTSg2FDIh6VuShr/EdBmQ20cZRykO62rR0MEdQ//Grf9wChZEBY05pmluIBrxjkbCUi5fcwUnhAzYVsXWbvOywMcmHKlmdid2eY7IJ/cFlqLX56beX0qMz7dptf7kClv2nWJ2/aBIeizaqdWK8Nnn7PS/myS0brHKnb4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AL5eKLTwOLaf1HOYNFLLpx7d7bVqFu5uhhbJgi6f58c=;
 b=RDJyg4BTYJ5hwOzu2GswKB6yHUIi3Hd82pkooeI4FjcqqR+1fR3sVaI/ndzLF7ECJi0YGAcJIU/KZXfGbm2p5aILQss3LgLbfVehsYpl0yi7KfyY4u0hbBcctWM83AqcrI1rl+mF5xiA1arEx1S3DIpzPQY3yZekhiX8yikQD1/Lf1ZmE5ZXys05gswz7XXM5O/T2TVOjC7KutvWvYKCXh42twC+ioIcR57tRr/BdwGMEoCzF7KjMqhhFwBmJK+YtoTbK0cCun4FVK2LZEYitqXe5lgqTmQCLbIE40xe8NiK5sY5XwqfL3KQhQCkBcqpnFnSFVNSD8o/xRy54I1oAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from BLAPR03MB5619.namprd03.prod.outlook.com (2603:10b6:208:284::16)
 by DSWPR03MB989105.namprd03.prod.outlook.com (2603:10b6:8:35e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 01:51:23 +0000
Received: from BLAPR03MB5619.namprd03.prod.outlook.com
 ([fe80::8d8a:17a3:6fa5:2be1]) by BLAPR03MB5619.namprd03.prod.outlook.com
 ([fe80::8d8a:17a3:6fa5:2be1%5]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 01:51:23 +0000
From: "Sosa, Marc Paolo" <MarcPaolo.Sosa@analog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov
	<dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: input: add adi,max16150.yaml
Thread-Topic: [PATCH 1/2] dt-bindings: input: add adi,max16150.yaml
Thread-Index: AQHcpLQa2+zJTK1CXEWXYMab+trvX7WQgscAgCGR5DA=
Date: Tue, 17 Mar 2026 01:51:22 +0000
Message-ID:
 <BLAPR03MB56190D6E7ED019E4FFE7F63FFF41A@BLAPR03MB5619.namprd03.prod.outlook.com>
References: <20260223-max16150-v1-0-38e2a4f0d0f1@analog.com>
 <20260223-max16150-v1-1-38e2a4f0d0f1@analog.com>
 <c2985ac9-1917-4044-a896-8e701a3046af@kernel.org>
In-Reply-To: <c2985ac9-1917-4044-a896-8e701a3046af@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR03MB5619:EE_|DSWPR03MB989105:EE_
x-ms-office365-filtering-correlation-id: 8133d58e-e8fd-4431-35de-08de83c7b15f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 h9sVjRWG2LQrfA5VQGpC49CwJ/Sm1Hp9xdTWh6L/OFCRxEXdpV13wt9/pQtvJE2x9pIGK+AZwpgTJeM7qguxea0WpruYa5JrKqAWbn5n9GIuV5nN3wAnL8E7RqGjMgF3cAugzcpiH3HXtrKVyIgPco3sNkkaeTfDozaXr6ZLNrDmJLaiN2V8f9L+NqoBKM466BWgvdFO6/Pmcm4Vzwb/PIGoT2227Cv+0Pexm+EaRrpkt6ixZAuSZWRTODgMvwK2wU3vyQlvubnh4stzF+P7L0XaBzI/CtVreKLWx0+c9UscBFDuVSHjXmas20k8e97v4F5LqBWpYfWgPb9F+hlkyJAbhePTcaqq/0BsEuB1KKePkrn6bbMECAE4cMlaK+YeTIUjAYTNZMcmzZmFY1Q1mt+vN6hvWVHKv3JiBGuLM5sFQhmC0pjF1cT9C734Y8tLlaTJdrXqafugfQi47h/TSZcS+JbcTMZrnOTuhaJNTwLTZAT5iv5pO6Hv7wvC57XlPVJm7Ip37lLbMqgEj9/b91YtoPtFqoN6HEmIK7LKQ2B0R4Nxqg93SLurvsJCGgBWBHQ2Cvsy7MCBXvw/hEcMFz2FZlUI/z0sirjt0CwxfBsJb14ZSp+wpdeUvuBWHxBhmwUzSmcDLFbva3Ld8UV0bkvhwDuF96hKjPJ/73K1yss9FIMZGg2wRNRxeHwVZbvDQkd8l2CyJgxzRpeJPF++iaN9ETIfOTxzjsGznz9204zq+skd8+ULWfTEPeiElp/f778zU6XK3ok2hP+S5gJFEuiMgudRcNg7Mldp3vXFFIY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR03MB5619.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SFZ0MG1RaVNDZVA4Qnk3UjlkZ1lEUmt6aWhzdmRINFhpeERWaG80NEJGRmhj?=
 =?utf-8?B?d1pnbVZuN2lVNEVKa1Z5aE5aL0VRK09OWWZrWG5LTDlvc3g0ekpJa1ZWNnlv?=
 =?utf-8?B?a0JISFl5a1JlVXIranhXbTNvdnhwWTZEOEJIdXU3RlJTWTZMM2dTbkJaQmZN?=
 =?utf-8?B?L1l2ZG9EU2NaWU1DSjdjekxleXZEVG1VNGJTaVcxREVjQThsbmxpc2taczIv?=
 =?utf-8?B?dEtQbUVKa0hJakwyYVhDdXBFT1AzUzkyaFpIWUU0NXVFQ0xoUHQ2YWNidXdZ?=
 =?utf-8?B?YU16OWczcmE3bEJ1UVR6SkRvT1hsZG1jeko1UGFPYTFud0hEL2lvOGxqL2Jn?=
 =?utf-8?B?ZUE2c01lZWkvT21Td1lnSGRYN0JXa3lvaENtaVo2ZHhZM1RLVERWNUpHVlcy?=
 =?utf-8?B?VkovZEhTZzhGdTcvVkRlbnE1ZGY3ZUpSMEhaR1JIQVFtdUZUeEhQdWQzM3pH?=
 =?utf-8?B?SkJnWE5ic2RiNGZmeWFGQnFzZEcrbWlFQVloVFBFVjlubkU0MnF0cGI0Q3JN?=
 =?utf-8?B?c1NoUko4K2RJa2p3eVlULzlldWhrUTRGejByWVJTMklmdVdGVGJzbkxEN1lO?=
 =?utf-8?B?cnRHUFdzS21yQzU0dWVZSDJlcnNLTGNBem9mazcrcGNjU0g1VmI3dnhjeEx2?=
 =?utf-8?B?RjhRb3VHd2l5NDg2MGZZbnVUWkhjWUFBUFE3bGdwVzByV2x5L1VYL1QrUm44?=
 =?utf-8?B?aE9MQk1nZVQwMzVGcyttVDhxZHVWZncybmEzbmV1NmZCd0NwZEFEM3k3azVl?=
 =?utf-8?B?Ui9oQnBSQ3FmYlJzbmNmM3A4QmhKRExFRm5OL1V2NlVib1RsRmZKTWdxejZm?=
 =?utf-8?B?ZHFkVFlkSjZsRnhRL3pMWkhDMExuc0s0Y25OK0RjVFUzWmN3ei9aYXdWZTZP?=
 =?utf-8?B?Qy9hamFtQnZqcXBCbjk3NGFPSS9BVHU2Slg4bVVwaUFqRDR5MmowUkk2T1pJ?=
 =?utf-8?B?RHl6T083eGhrL280N0h4aGJ1MDUzdERaVnRLTUZFaFo1UEN4a0x0akZTUjBm?=
 =?utf-8?B?U1Vod2xKaUxlaUJSWG84eFJUOEJ3UTJXV3B4OXB1TWJON2d5Q2VRYjBlRkx4?=
 =?utf-8?B?NHZUUVBDcVZiWkJoeEw1NWVZMUpTWll5dmhxdDMzOVR5Y0J5cnd1OHhNZ3cx?=
 =?utf-8?B?d1FsbXpkSnpsZWpqM1JyYjJIc3A4cm9sTGxWeVhxSGRuTFJ0VEtmOHpJRExK?=
 =?utf-8?B?L3Y3ODNZdE04ZUZPL05Lc2J4R09maTdOT1Y0UlgraHppQWd6ZUxXWWNCVjBH?=
 =?utf-8?B?L0Rnb25KY21MaHhhU3Vwd003KzQrb0psMFVna2dmWEx5YkJ3bHFNdnprU2Rk?=
 =?utf-8?B?d3JJUUwxMjlpa0hYcldhb2kvNHR3U0RSQnhrWmRrbmlmVWpHbnBUR2hXZ04w?=
 =?utf-8?B?cGZ0OTBNbEdzQXRzNXlsQkEzeXRON24yZ3dGTzFYWVRwaWJ6eEM1NGJpRFFl?=
 =?utf-8?B?dmtpZlp0cFRxblh5aWVrNVVYdHdqMnRldWN6a3d5MEZDTDNocWdYV3BCOGJn?=
 =?utf-8?B?bEZiWk4wRlhzaFNxVy9yUEExZElKckFFWFFPMEo1c2l4eitLaEVINmo2V3U0?=
 =?utf-8?B?U1BZdWdOZFB4VW9kb3NRc2dJR1dKT29EWnVBREQxSUVSRTNSYmRBQUVHcVB1?=
 =?utf-8?B?UDZIZWZHYkpYR3lrWGc5TmxWcGJiaXR6dFYzREk5ZlRyTGNlbmhjRE1YUkIw?=
 =?utf-8?B?M0o4YVM3Z29VS0F1VGp1eXJ0VUlkb1QxSHBVRjQwVzQ1MmExRnpyZ1dndUVE?=
 =?utf-8?B?NWF0U0FrR2I3R0I3U01SdmhVZDdwZ292WW4zVEdXazB3bzZ6NTR4RE1OM1JY?=
 =?utf-8?B?ZjN5RUQ2R1dCYlgrS3p5RzExdWlRcitmdFJ2ZjBxUFA1ZkxOMWUyM05KL3ZF?=
 =?utf-8?B?NHdPbzVDamV1Z3cvSmtBL0lBSHRrWHRYamVRQ3hzNlNFWWVOQjR4SzU0ckVn?=
 =?utf-8?B?ODBFbElZOENyZ0lGb0dXelZFNExZTVUyL0U3akJmcUFTb1RUdld6bCtpYWNF?=
 =?utf-8?B?YytTTVlsZTl5QllnZGZ2SmFscnVjMnFjQWJYZXowOXZsY2VPQnk3VHlFTHNu?=
 =?utf-8?B?eWpvSWl1KzhyTnlxb1dGTVc2QVROWlcwUWFGOHgzVHBkUUwwSko2K3FkWVJT?=
 =?utf-8?B?bmorY09yenBESVVQeUNQNzFWWCs2Tm55U1VSNVlDYXkwS3JvQ0VlQTJQdDZ5?=
 =?utf-8?B?emxUWmttUlUwbFA5SWNmNEg2WEVWRllSTnFOVklob1VmbHRZeFk4UTZ3cW5B?=
 =?utf-8?B?UU1GNkgvUDI5TmhMSEVQZ1NuMWdZaitEaWFUYUZKSjVpQmlkWllYUUE1NHhp?=
 =?utf-8?B?OG9adnRyOEFsRkNEVmxHVDltNWlCTGpETzRsTm41YVdWUjZoUk1EZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	N/BmEzSbeT43kOyV+8Odh7/FlDY0NHrS57DE1HwwuHpT543lDZUIPSJw33nqIfTNEAAtMAVBonP8lXADndUwCKqayE1ZVNdsajsHbzrMie8QRIj+vJB+G1bFZCHoyZ0mcR2dtb+bmbK0U0Z9S7kT/QJrjgL0IB0nhc2lZqJf/KyvEINa2ckleTs6SGSSD68QbxN086H/KFMSo5BFS+O38aArexIvFotIgd+yFe7HJAOIKDPSKtOYRnb0nlO4IB9oXncfKkqfmhrAwvu2TQ+oFFk2z5Ah7xz2fwHmRll/8JpGMnmVsKUzJ2ob/qXdhwhxBHFk3Ag73QRuJ5VgaY7Qcg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5619.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8133d58e-e8fd-4431-35de-08de83c7b15f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 01:51:23.0234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KDBl+eYChNSTsZ+26bWKj2146bAg5NQlt+3+NMHfZ2So9SC0AbgcVBl8+EsNWAo2M97WJIxb6tbtoRGuLI2ZyzL060/QAR8BtkzgjxJyhoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR03MB989105
X-Authority-Analysis: v=2.4 cv=Y7P1cxeN c=1 sm=1 tr=0 ts=69b8b3a5 cx=c_pps
 a=/Dg/agRq+0IGp9KZEOxzXg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=iZSIUCweCk2Oy3QsdGPA:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8
 a=AKVNOprHjoGjR_QAAkYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hBofBitivahH7Usb_RPXtIjGogUi9xag
X-Proofpoint-ORIG-GUID: hBofBitivahH7Usb_RPXtIjGogUi9xag
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDAxMyBTYWx0ZWRfX9hZrb2bCHbUs
 2tNjc03W4oATqh6wmb3K9g5xUicWQnbr7wyHYKVo6uj8qPZcEZ0NKyMWEUcutWIE6aADL7fs0kZ
 MCP1QXEATpCuVMyG+ZLMpBPowGM1PflvNMt3fBGYaBbpNeT4q1QWGH2+xsAr/YViooK1RnDuhXF
 04IBC1NcAwfjiu8OvSR/xEteCxXw86GEFEEyDFoYhq9jy/7QekhRBPZdrlx63AA9J4asxxjPvfp
 lT05XoYlR/md2LkSW2sOZHEoaUHQR5c8qH8NCf4cRcpV4tuV6H//3HcJ3RFYR1qrSJYinwo15LV
 wg0MtXV2PYbjd8CPwxyHD+luHY7crX62R3KuZfAtRrHdwJysHAPfnLMrlrrJFa0kkQrlmznPVZ5
 ISbbYAbsGwOhPvKQHSOuEZe2XM2bu+NHW2L/kIMVOP4SE4fW1ANl+a/9n57/dbbsQcdxevtWoUk
 XH3Y9kDUQ4AXuWSqa3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170013

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAyNCwgMjAy
NiAxOjAyIEFNDQo+IFRvOiBTb3NhLCBNYXJjIFBhb2xvIDxNYXJjUGFvbG8uU29zYUBhbmFsb2cu
Y29tPjsgRG1pdHJ5IFRvcm9raG92DQo+IDxkbWl0cnkudG9yb2tob3ZAZ21haWwuY29tPjsgUm9i
IEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZg0KPiBLb3psb3dza2kgPGtyemsr
ZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz4NCj4gQ2M6
IGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
MS8yXSBkdC1iaW5kaW5nczogaW5wdXQ6IGFkZCBhZGksbWF4MTYxNTAueWFtbA0KPiANCj4gW0V4
dGVybmFsXQ0KPiANCj4gT24gMjMvMDIvMjAyNiAxMjowMywgTWFyYyBQYW9sbyBTb3NhIHZpYSBC
NCBSZWxheSB3cm90ZToNCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJs
ZToNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBTcGVjaWZpZXMgdGhlIHN1cHBv
cnRlZCBkZXZpY2UgdmFyaWFudHMuIFRoZSBNQVgxNjE1MCBhbmQgTUFYMTYxNjkNCj4gYXJlIHN1
cHBvcnRlZC4NCj4gPiArICAgIGVudW06DQo+ID4gKyAgICAgIC0gYWRpLG1heDE2MTUwYQ0KPiA+
ICsgICAgICAtIGFkaSxtYXgxNjE1MGINCj4gPiArICAgICAgLSBhZGksbWF4MTYxNjlhDQo+ID4g
KyAgICAgIC0gYWRpLG1heDE2MTY5Yg0KPiANCj4gWW91ciBkcml2ZXIgY29kZSBzYXlzIDE2MTUw
IGFuZCAxNjE2OSBhcmUgY29tcGF0aWJsZSwgdG8gZXhwcmVzcyBpdCB3aXRoDQo+IGZhbGxiYWNr
IChvbmVPZikuIFNlZSBleGFtcGxlLXNjaGVtYS4NCj4gDQoNClRoaXMgaXMgbm90ZWQ7IEkgd2ls
bCBhcHBseSB0aGlzIG9uIG15IG5leHQgcGF0Y2guDQoNClRoYW5rcywNClBhbw0KDQo=
