Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A0829D273;
	Tue, 17 Mar 2026 03:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773717248; cv=fail; b=BUEuXuMndNNmw4nVKV2F4LhCqdRAWQQuettcZt4b20V1kTH4ZtYBQi2HS4uLk+g4Qt/iYNBNc5UPvl+gXP6OOj+imUi2cIIL9SBLQyzH3Z613TXpqTttGUAGLcodEqEli6La2f28ma8wMct4qaV0VZrnwkUKtFyzij1jpaixH9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773717248; c=relaxed/simple;
	bh=B4UoyFP87GmFvtcAxDVTPcQ0rc2YrkzH6tIxn8rt3dE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jCV+PQ/PxijBVpSyPpiVUhNvOWVCQVHvU4o3PvibFOOK0c8bJA/z4jOF1eXX8UU1xZaVz3Dt0QZtzdpf6qdlRml28bwomgdDnGTriKP6h9jKHxWtoHX7X7lVdeKWOnHhQ6OznJQhBMnCz1oFT5ynyMvMzshWxV37/F3+pGHDZyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MiBRrhO2; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MiBRrhO2"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H1fj0i609887;
	Mon, 16 Mar 2026 23:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=OszYO
	r7v7S2Y299RS0jA0fJTnXTvrubSV5X9s21aUXg=; b=MiBRrhO2qyeIzQliv3xYS
	8RLqHlxfLylR+l2bwKu3EsA4NN8tpo5vsAT044TY8xNIHhyHmmyDMD9EnLFM9g9b
	+NAjLD6cJ5p8LY+mIrDs2bVOMS4MmAyKzrwJmtNIXKvgyJsWCIG84dGmEsSXdpMq
	qd/7K0hlOCyWgLbEPUXZyt2mJcE0PjPiPv0b95cwRTuJ6yY6vwaP7tIuJXCQeRg+
	rg2+y9f90YeKxUlPz/5wuryiSDGLy91BoKI2Rl85Lo5uOJD7FHt+vMRRpBkEuXmS
	XL1oc/+4anLNsA469Mu3K4s/A2K17LATnMjJvUBdBfflW63qoTX53XRATFCw/Dc7
	Q==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013013.outbound.protection.outlook.com [40.93.196.13])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cx2em52rd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 23:14:02 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WoK6iNa4Nk6d71/tKo6kLBf34dY01svl6qnjqj9/Q3JpMdY2Pn8Mi8M8C7QvX/2MxFLGnWf+J1krO1Z1jMX9ag3+yxufVnuk0k2FecRi4N1x1ddutBdctSMLMmwOOzxQLUEF4nbNhmpyLi+hNoonoOMI7cemQCYO3s1fiXo2UfrI/M/h4MIC557hkwlHX14l71qjUVnFVB9CkHFJTyvUixwE/4Zq11PZCuZ52E5V2NDCxQ5eCVkrNI5KKCGkh+HcrWO4bMz49MHG89AYPsFDn8MmBJxKbrNt05vN0yaV0kbLk7hPLyiNlYDnwl/RijSC5rtvdw3pkmhQtuaR1aIJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OszYOr7v7S2Y299RS0jA0fJTnXTvrubSV5X9s21aUXg=;
 b=KCgPdqtK31OZWHSdJSg/934IiGg5fAJmK0As6KOvo4hiRi9r70+WhJLBwV7qnxDf13YQFY9iBlbR3HBVzny2PTUo7Xwzi9fDNgvrBPr26JKqV5zQ4ICM6pXum1HiOFVvbAfnU6NITtEsvIn+ZC5ajkAg0ux9tV8dAg6ifo9/J/MLarI+40vn4kir8rt7YAf7Jj04e+pgfZ07xnhuQMLGxTnR5Q6a5dT7prAbHwMAGHsOa/YYVh9jOkueknVNBWTr8QZwGXz8SqnD7o5UpKfmNblljxyKY/A+EBOaVVBJT19vZCYN05LuDojHjcsZQHDhaunu/UCUUdy603Tk32m5zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from BLAPR03MB5619.namprd03.prod.outlook.com (2603:10b6:208:284::16)
 by BL4PR03MB8037.namprd03.prod.outlook.com (2603:10b6:208:58e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 03:13:46 +0000
Received: from BLAPR03MB5619.namprd03.prod.outlook.com
 ([fe80::8d8a:17a3:6fa5:2be1]) by BLAPR03MB5619.namprd03.prod.outlook.com
 ([fe80::8d8a:17a3:6fa5:2be1%5]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 03:13:51 +0000
From: "Sosa, Marc Paolo" <MarcPaolo.Sosa@analog.com>
To: Rob Herring <robh@kernel.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: input: add adi,max16150.yaml
Thread-Topic: [PATCH 1/2] dt-bindings: input: add adi,max16150.yaml
Thread-Index: AQHcpLQa2+zJTK1CXEWXYMab+trvX7WQf6UAgCGu55A=
Date: Tue, 17 Mar 2026 03:13:51 +0000
Message-ID:
 <BLAPR03MB5619C75CD20CDB2F817C7BD2FF41A@BLAPR03MB5619.namprd03.prod.outlook.com>
References: <20260223-max16150-v1-0-38e2a4f0d0f1@analog.com>
 <20260223-max16150-v1-1-38e2a4f0d0f1@analog.com>
 <20260223165034.GA3975976-robh@kernel.org>
In-Reply-To: <20260223165034.GA3975976-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR03MB5619:EE_|BL4PR03MB8037:EE_
x-ms-office365-filtering-correlation-id: 68a3bbf7-a826-4ba7-5dc3-08de83d336e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 aH7rFUzkuk/YX2a5QqwdJhN9zDa0x3wGYFtSaUG7ONlxDqWvYXWfwGJvuLTUrLLESRi59juHM5KTuUdqbE2YcCYM7XFtaQtWrHASSmCc+i/mydOpK1fOYFy14YzFGzNARreHOt4LJMsnVH6LaWASbE2C7tG7eWA7oiLG5XvLbLLbtrXzDsLueCxQYica84SrNCVQLnFLRp813MFS7QZbMZDMAYpyPXnqwWbjihbt+VzteyXBhBoXjf6XGH+XjyiCHuLO4Fy3+oGwLBEPM0GgLJ9s6kMuJCmVfHu7ogVwHM9wJbPx+aSuLBWBwKpVtDUx5Xk8w0rYF6wNvJ3WGQ0sw7AFolgD4sB27yxUFPMY52kXO9KrYEPjdzn9dKlOBiW9zUda55zNwTHiB5Rf670gi1PwUvpwD2uoKTHtaaHHCkBAaUfKsmHfaUCbOd8Z2jwN8mIV5Ivle98LMrRcysbEKdB56+fvMg4KHMO+G2MSxvoFYWPHa5QL+RzDViunFTo6Ij1J3wX+JTKHoG2MtrQy54kqWcRewM01WZh4vkntFvrcB0sFNCCSSP41uUHdOFdloCecMeBzLkMm+FjK9/y200dhlCoEwimH3/ZGUR+KsqDF3BcwNApeNz9Tx8eOnO9lEuRope9uQ9ahxGGqa8uJGTCGlansP4PtVMxND6uSRmXLCuum2KxjvqXi1slonJBw128iIk62oRLIttpdvOnpWtQ2lAorD0PLG0J80fRpy43j/7eGkyek7+tgdYRdJ5XY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR03MB5619.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4Rs3a8wVvzeim5gstGd5VxdpAOKV5xlG/lGRihK6ogHYCVq5Q0ehWI+QKdZh?=
 =?us-ascii?Q?PRyxE4u4aqJcirfyq0JyyGFa7MAUFyJPAgySwDsve9fdusXaYBNdvLyjRPOJ?=
 =?us-ascii?Q?EkmuAmN9+Uvtm2Eallb+NThLNMSfEWLNBq/2RK3q4aC+bKzkeS/QV+bHa93l?=
 =?us-ascii?Q?uRvwiDRCzwoJsyajmczUPw0Fk23cq94oj0mjUQgv4Hh1T05XJ6odqZlXrHLO?=
 =?us-ascii?Q?L1sYb/T2L2phytV4fsWrpyBUyfKRjAGemTi6nB5s/Yg7Pn4i39oZPHryODEg?=
 =?us-ascii?Q?cH/RaxGvXLh7rNlr5b08rAgRVzDnk8iWZvaEWACn581Q3mZAmTGLErAhHQ4G?=
 =?us-ascii?Q?QdKHuU8auH1pZseGO2D0XlnFyZqKVrGfCqLN4u/dbg9IxOL+KJLpYxO8Jxmm?=
 =?us-ascii?Q?FaIEPZXO1NJ1qIbxmMU8dqGUfT3NtgrAp0wdfQK7kz1ccrfaAqSiHxWsB4VX?=
 =?us-ascii?Q?DrkFDnKMU9Tk+em1oesNCzsGw4KTVjRvjscWNxlryJL82ysI6pS/H/cLt/SQ?=
 =?us-ascii?Q?xcqbGU+Wjs66QKih5pu/qzwJ4e9imga6xDzA16WckCd7vuIfR+Ol69lKw6Ko?=
 =?us-ascii?Q?seVh+gHz6bN9DoXzrFDVmVkSFxWjiCMo+ut5ybEMnsEhUprcm0VOJFcSUQRI?=
 =?us-ascii?Q?yZ4ccP5BVgMm9M8NEIAj2TjaQNxz3I4Wwiyqxnf5CwLPynoJIPR+p2DflAat?=
 =?us-ascii?Q?HJUmbT9JEGeSSgQacQ6MMUDIWy9D2deAahzoRClYTVbCpZqQg6QYFQCFxvrO?=
 =?us-ascii?Q?KiFpaI2vzNLF+V4dj4//luLTjeoWp4TGofSCJhi30bVYyJS5WZE1S2B/qRGt?=
 =?us-ascii?Q?8gS3n+tygtoN9BLxPmZPl+fz/ztXlqdQzLEje87aaqAUeezb9Fs7BEvuPpJ8?=
 =?us-ascii?Q?SD6LDTB6/ya9crZ0YWbke3FJqv/p2QvtNHyv1HppMvDPvQTI4fxk7htlelyr?=
 =?us-ascii?Q?z75PrY/Mk3KVeKF+20VhaJqHKioTOCZqz9/viNcfu65uMhPRvShYELhF12ee?=
 =?us-ascii?Q?klb4y0uGy8fR0wXPdnBUKTx48Xaj/WRxE6xIImfC4FdsYRLOQ4gQlsY2TxV/?=
 =?us-ascii?Q?IvV1L492dRwfWdP+6pD0C8Zl8CGgyl2zIEH7TiW2h92/QEnMS4tWESw/YG9G?=
 =?us-ascii?Q?C/cZMxNxEqKbAKVEa30JDaSrOkAGOtaSgj9iLt0NP+IC3P8X0dM9Bmj49nhs?=
 =?us-ascii?Q?5p8a1RkA/komDt3e6QVFUeI1ekvceyVLrJ6+bLQwPVZVPvGuWTCWMS04rbZn?=
 =?us-ascii?Q?np85nyo5ixCGOKV3olWda+peP0fGu7wyBIyGhGRHn0y6z99AFkyghTrRzEiX?=
 =?us-ascii?Q?mK2gZLwaykjeHWiOo1myWr/91bDsyQaoJ4ngN87juvzo8iyATMQEDv2yKQms?=
 =?us-ascii?Q?S+RPa4VPPL36lhRkgpe4+J84kql7XsGxer8Kh1r3x3TNTEsGD3LauvVb6dy3?=
 =?us-ascii?Q?WHWGURi3K0PXzwYeyWp8gwNT8a/QDdpOH/GtvVJVCTrduNPWqKfMzzLseEsn?=
 =?us-ascii?Q?jS0+yXk9hXUbClRLt31L7ocEFIgmZtQT+Rn5WPwaue5SwOcYPYC+8dSsezyL?=
 =?us-ascii?Q?VL06esdk3otZCjbLeoIQp6+HowQb4Subjf0gnGH3vM/L1gyWRPLx0cT19iai?=
 =?us-ascii?Q?AeikiwgVuYbS972X3Rr2ySRf/pdraLGtb1OrzKH6UD8L47rc1vAkZaBvY76V?=
 =?us-ascii?Q?FXco32e7ciDQyb5c80roObbJSyqw/9NVSfcQTy4DWOT5lAAywTkTot1nQr7c?=
 =?us-ascii?Q?jJz7h1WfKA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	wd1bxShOqIc6Kp4/QX91Hy+f7PMbwTDMjuaV8/5mI3+Bd2LhdWN4ellTsqfKK8BqLsdjLM80yzpuqc2Ycui1xXmgXqI2xqBBB6kwGBxtAIDFv/xGA1CwpWjd+bu4q96Xo3USoEe4e8Zb488sJsrGdORKdKz1Dnua4kx5SFJPx4iPcyrSvJjQ5u5K7BLqKpAw6B64dyGF86jiT+no00avy3s6NL7BusQPUtBXffvYiRCRKv2azqdSX6wOTD5sgLZsa2dgVH0AAWuyNY+qjIV3dI7Hqo3greX2b9l2t3Vz8lzs7h9N5cOwb6lbOcYYbtCg0n9j/bxKAOivsFhtXOxRjQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5619.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a3bbf7-a826-4ba7-5dc3-08de83d336e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 03:13:51.5528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LXgJVebKOVdu3hs5rc0kTM/EC/MoyhvDRyNrUghQU2lrYyS5jylixwRIsHSLvZlGe28HYlYtH9MxE3uGASm25exsVAL2GYL4JykY26BRIbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR03MB8037
X-Authority-Analysis: v=2.4 cv=etTSD4pX c=1 sm=1 tr=0 ts=69b8c6fa cx=c_pps
 a=fOo0+MOGfjr111H4QC4BGg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=uherdBYGAAAA:8 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8 a=0QIp6lwxEw71Z5_Y8NUA:9 a=CjuIK1q_8ugA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: l1QyxAehhGdjoFyc7n3jhazevFKzW7CV
X-Proofpoint-ORIG-GUID: l1QyxAehhGdjoFyc7n3jhazevFKzW7CV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDAyNSBTYWx0ZWRfX4iMxg0JYXAr/
 UJWkxBwdyvKxklxKrdePQvG9zKKhWHkPOsaPs3nzc6SXw5jHDNwBJF8OWCwy1vVwaecTgr+YK5g
 0SyC/U6tFWsN81Zyj2eR1Jh2eYibDdHaAwaXiekmGvmPGu4Xzmn5dQ96HUyrk8JUywPPI8BxOrL
 gCT8ER++st84J8o0Ss0ZeanwFhSMTdNNn7lhijaRUKEbvkEVJf8zw7tVmuMZ7U/N/pWQagmuQmN
 pnKmn4wMAfYK+IRo2/RH9YIb0n+tR4303dWkK5B0BPupbBNkCDfj/I3ADRpswD9SVRUNlm5x74e
 hu5Ta0yOW/sd+pXZECVfklNDUY1Sb76Qx3CE78Orqb/DZnW+65qqK2NlOwXncIJ9Wka5YRjQkI0
 f3h2AfyqH9SQm7Ae50s9vr9woz8ScQu17TX5zMbzScmg44c6S0pOUVFihx7V+5qicSfES64KpvO
 6+C1xj8i79uqdvKb8sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170025



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, February 24, 2026 12:51 AM
> To: Sosa, Marc Paolo <MarcPaolo.Sosa@analog.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; linux-
> input@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 1/2] dt-bindings: input: add adi,max16150.yaml
>=20
> [External]
>=20
> On Mon, Feb 23, 2026 at 07:03:39PM +0800, Marc Paolo Sosa wrote:
> > Add documentation for device tree bindings for MAX16150/MAX16169
> >
> > Signed-off-by: Marc Paolo Sosa <marcpaolo.sosa@analog.com>
> > ---
> >  .../devicetree/bindings/input/adi,max16150.yaml    | 57
> ++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/input/adi,max16150.yaml
> > b/Documentation/devicetree/bindings/input/adi,max16150.yaml
> > new file mode 100644
> > index 000000000000..327811e1ebd4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/adi,max16150.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://urldefense.com/v3/__http://devicetree.org/schemas/input/adi,m
> >
> +ax16150.yaml*__;Iw!!A3Ni8CS0y2Y!7MP9aN8nPEM3L2rIf_pWYnGRpvrMnRa
> dsVK3J
> > +dATD43g-6ZDMtcTwePpZWP1Ji7DaZoV6c0Iy5nMrfJM$
> > +$schema:
> > +https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.y
> >
> +aml*__;Iw!!A3Ni8CS0y2Y!7MP9aN8nPEM3L2rIf_pWYnGRpvrMnRadsVK3JdA
> TD43g-6
> > +ZDMtcTwePpZWP1Ji7DaZoV6c0IywbOF-bm$
> > +
> > +title: Analog Devices MAX16150/MAX16169 nanoPower Pushbutton On/Off
> > +Controller
> > +
> > +maintainers:
> > +  - Marc Paolo Sosa <marcpaolo.sosa@analog.com>
> > +
> > +description:
> > +  The MAX16150/MAX16169 is a low-power pushbutton on/off controller
> > +with a
> > +  switch debouncer and built-in latch. It accepts a noisy input from
> > +a
> > +  mechanical switch and produces a clean latched output, as well as a
> > +one-shot
> > +  interrupt output.
> > +
> > +properties:
> > +  compatible:
> > +    description:
> > +      Specifies the supported device variants. The MAX16150 and MAX161=
69
> are supported.
>=20
> Drop description.
>=20
> > +    enum:
> > +      - adi,max16150a
> > +      - adi,max16150b
> > +      - adi,max16169a
> > +      - adi,max16169b
>=20
> What's the diff between a and b? If nothing s/w needs to know about, then
> maybe you don't need to distinguish.
>=20
> > +
> > +  interrupt-gpio:
> > +    maxItems: 1
>=20
> Use 'interrupts' property.
>=20
> > +
> > +  clr-gpios:
> > +    description:
> > +      Clear Input. Pulling CLR low deasserts the latched OUT signal. I=
f OUT is
> > +      already deasserted when CLR is pulled low, the state of OUT is
> unchanged.
> > +    maxItems: 1
> > +
> > +  linux,code:
> > +    default: KEY_POWER
> > +
> > +required:
> > +  - compatible
> > +  - interrupt-gpios
> > +  - clr-gpios
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/input/linux-event-codes.h>
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    power-button {
> > +        compatible =3D "adi,max16150a";
> > +        interrupt-gpios =3D <&gpio 17 GPIO_ACTIVE_HIGH>;
> > +        clr-gpios =3D <&gpio 4 GPIO_ACTIVE_LOW>;
> > +        linux,code =3D <KEY_POWER>;
> > +    };
> >
> > --
> > 2.34.1
> >

This is noted, I'll test this out and will apply it on my next patch.

Regards,
Pao
