Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B302D249B;
	Tue, 17 Mar 2026 03:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773717182; cv=fail; b=nCNx3EaFlvukK6oVSshAwsT3Zu2xKqdQhEpWaQlOqCADLrnJ2yDBLxp2Hpm0lIvcIgTK0tJyA3u+F3cQwcvH6ZIjwevxJuczrxrVCPhJAeAcq4KLgO7a+vbDD/eAN9bCHcb2H5BfmZnSFkNkdPc/AvKKat8ObEbfOfpSHylrNNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773717182; c=relaxed/simple;
	bh=AKdwzQXN0uQ0onAfIebQXpIAjRL8pIoygtsuJCgh47A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F3s4xGAQoYDSjvbgZDvOiTWbOFve+Bst57BTVbbZy/1ufOixjX6625LNqPoRWPlDkblVzVNl/TJvFFsODC8qyUvqTncOid6m96BdUbnNj6Jlqf7NQ4Kiq/Ov8ghTNJquIjUdPT8axqJKw+hTqKSTx9fkVn66F3C7MgpaS46m78Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=v1EVaYyW; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="v1EVaYyW"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H03p2X407856;
	Mon, 16 Mar 2026 23:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=eAlkN
	hnvVX62UdWG+iB34vjNYXl79MOQdCdpbHNmhWI=; b=v1EVaYyW/gB6vvfiZOoAA
	J6OineFt9K33UDloOVMzqGT4J60CrtUeCvNHJiD7RRBvoOl+YtCwALXgtwySjRfa
	QTYK+C3YYdx/U1peHTjlAmlwUZoEV1t/85FtPAnis3knPlO8/Ha1OsfdGLayYzA3
	h6I9+KapcHXTq1jSrKjw0VhqunSBqejwWH4XFyd/Z3uglTFA4xQJF4ovpdhofmZ4
	ynuopcicmtNPUaqg6ZFzzQhRlRJhd2kCVLIFnnXSZCQy81HErWKUNxhNYiXQYoS3
	vHmG5i7YHU9/Oik0+bZIEopdsgDXyLXH60p1MzaF6vaOPh++kJX1EAVpccRS80j5
	w==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013005.outbound.protection.outlook.com [40.93.196.5])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cw1e5re5w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 23:12:56 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoJQzFSQ7+Wrphs8Bj5GuxPpEMmpjPo+dY5ymJc4P9mj1vRLcOSminaT7oC7pYexAl+OgYzoLuvikAuYCcTt5iSVa1uqix1cKJ7ynck6NEfWr83KvuUkU2IUKkjFdiMkr4ycoBImbbY1+r+EMd0HTAhQYZRuVzOP+XfDXau9LyOXpdIUmMdzp1rkBg5ncEYFRPUiD53wGo15OgQ3kAM8t3KZ1xrJLno+fl9Edf7GtZ72RZFj4cfBV/B6JPf7gzDVher2bUDHQIdPGqLz2783KdY+mJMZ7W64x4XZ9VavEHs8/L8wZkt8aoNDfoIm2fe/UlbD1ibU1ee1CsAwv2sS2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAlkNhnvVX62UdWG+iB34vjNYXl79MOQdCdpbHNmhWI=;
 b=B2YPy0KAFhdQcPJk/DWUPCXpxAF35OKk8meW0Hgnl9Mia05a2C/9j8FT4XQ4cfd1V7sFkULR2H1wNCA4isMTbVfvkghb5UfEacIImpCpYMTinRO+nA7UtfyOMrSdWe36Bkv4quSmDiwDOexpYGh+0NNyppRjMGo7VJz3gIN2TqClxvQNNl7zmymEa+X/Roe7e74XfgzuAytD4/rVQx5fNLPuBeQa4jnboeN02ytidTn0OzdzUnUM9MvkBniopuLTXS4FtEPPgu/MPRuH9hd4i/8kueS21jXMNzB78whImShMBdFyN0WgN/dzYGwk24fAQSf+/NZxj4OPilcG73Mtgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from BLAPR03MB5619.namprd03.prod.outlook.com (2603:10b6:208:284::16)
 by BL4PR03MB8037.namprd03.prod.outlook.com (2603:10b6:208:58e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 03:12:36 +0000
Received: from BLAPR03MB5619.namprd03.prod.outlook.com
 ([fe80::8d8a:17a3:6fa5:2be1]) by BLAPR03MB5619.namprd03.prod.outlook.com
 ([fe80::8d8a:17a3:6fa5:2be1%5]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 03:12:41 +0000
From: "Sosa, Marc Paolo" <MarcPaolo.Sosa@analog.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] input: misc: add driver for max16150
Thread-Topic: [PATCH 2/2] input: misc: add driver for max16150
Thread-Index: AQHcpLQZTZky7/t+tkWl9JFuRaI17bWSdDcAgB+pgLA=
Date: Tue, 17 Mar 2026 03:12:41 +0000
Message-ID:
 <BLAPR03MB56193BFB549624E46DFC8776FF41A@BLAPR03MB5619.namprd03.prod.outlook.com>
References: <20260223-max16150-v1-0-38e2a4f0d0f1@analog.com>
 <20260223-max16150-v1-2-38e2a4f0d0f1@analog.com>
 <aZ4nA33Lc73L1D2y@google.com>
In-Reply-To: <aZ4nA33Lc73L1D2y@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR03MB5619:EE_|BL4PR03MB8037:EE_
x-ms-office365-filtering-correlation-id: 37f00a06-6501-49f8-6526-08de83d30d3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 soAojwKD9b/sjY6OXcDUr9SN2b//erxEP8Wxh8i0XcbT9v+fWxlXGCuh694mVbXVzjCHhrwCVeUSKTW2bnjeR/GLnJPAlDyB7ETVoS5jTl+yPn5/e06CTI5bZ89tIRiH7q28sodqyIbqq9LxHVYlhejRAh7dq5HSLzW6XYivFuJ7mgB4E1z6qgm0wUCom4H4vFeL36WADofuZZCO8FFVyFG+1LnmdD6KWe1L4XbwxK0CJOtUwF7kkuFUqNuuVb8WyRIFxjJjf4IFYfdX3jc18BIOylAmQjTmpBo2AUFPfPHNGqBKrajPUWtNkX8Og323YInu/Cj/gNTu8ztSjEARxxFUSOXjg9o/scCxI40BRlkZM+uwYrnW8sxh9XGackDR2gHJp4TUay2182cqMFg9pg7uVywVtm0kQh5UvnXgt+w5R8i9IJzxcZRx/4Gj6cPZbr/1oiUcO2TU+Y6fgvpVus9xQbWkph0Pq8/z68KDMq7ssSdY9E/QFDTjTRdkKlGmwR6EotrBJetfGE4wrJr/FFUCYdYDKMTe9XpjWPsqNGwExavH8H7wl0RtrzArVAOLOvSjSU9YByPZgo9vrHOM3QBBxulKZZVBgPAXkjmwX6tnUZOrADRAKj2JkdDttbCYyYs0tAHwbSVVjnfs3Rvr5ys7Ff1sW262dbFo/b0FxJoy0BJtah/XDKTe2mSNQi2rnCGS6xfLUrTliSURnD+Mw57BoH1yGOt1ueFOu3+CLBtZjvgIkuWE5tW4tXBtONynr6y1o01ROZ9GVEs6UCqqf+YCAs+HrvXmfMb6NUhyugk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR03MB5619.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4faBL8EGys81SnzHgTQHrncWkqUYtSLW4np20udYOsFchgEPiiDlidrdnCYd?=
 =?us-ascii?Q?nP8KTZNMF3RhoNZOoReDYw5nQ7sQuMxmQr+pNgZPCbTKdn/UNakMO11CagQY?=
 =?us-ascii?Q?e9fvvR8f4itG7sBl7n/T+C+nFhfSF8i9BCcSUq7Mk51/af7ihFPa71JfAWL9?=
 =?us-ascii?Q?VTPvtoAEFPstA3Ux9ttQIT39QJksjEeu/vLByGfvyPZ/SdkHRDkvTPfK8f5K?=
 =?us-ascii?Q?20d6lO8eRE/hRfWOVFTuOEzfttxz3xZGa1WgE4bkYxBUVMYuyebB32w02PAq?=
 =?us-ascii?Q?akgc9ZssbQT0AuQM5uRBF2YgRdrGNyhxLRjuX+38wLPBgnz06SxrplkuL3q1?=
 =?us-ascii?Q?cuzuiqaaFKqzLuQocer4HZf5E3yT6Gu7WSGRTXCcY9olsaPsPKhTmZj+1qMU?=
 =?us-ascii?Q?2K+s9h2+jG0EZhyPTRHbRDVdGIpU2zrnuSDT0py7MZrzJ/UOh5WqUAfcnYvp?=
 =?us-ascii?Q?Jn17xeX+5sj0aKuk7AuzMVrEiBi6O3IZd7Hcm0ZDNjTt6vBwDsqYNq7QNCnC?=
 =?us-ascii?Q?JGnkai2Ah54EjjcB7XgsXGR19GGGEqqu5yfe2hwD+HUUZJmhBkGAPWhDkYbz?=
 =?us-ascii?Q?x3a5+tc5W63TfOP6qQxNBAyab7igSOKqXTF00C/G0KecXp+7HmtSNSgUjEOM?=
 =?us-ascii?Q?3cae4Eo53NC/RLJ8Q3IFFX9hJQYXK3EwDz3TXwXfxao9oT60bDeCYKPYdk0k?=
 =?us-ascii?Q?twOLrX4SDJ7PDa076lMFiKyXmPX7VlhW1F0y0BMDFlsM5is2YLlwMHNQoOr7?=
 =?us-ascii?Q?D3/3gVPhXTRq4NZW6bPFdBQiWLfwtAbv8OktzzzXy/l1jKOGcOBsCZ/fjyLq?=
 =?us-ascii?Q?XVwe+iky414liNPezd1OqSpCJzDQGkwbFMqDH6ZTV41HUzQGS88SStlK/VNS?=
 =?us-ascii?Q?fhyC2HBCU+R1b9C1WwMi5/XTFM/U50aBbPfH9vLsqkLr8g0LQyWkXrDE9URY?=
 =?us-ascii?Q?7/5ELNVGBUiwV5jXZ+DQ1mDtF+24jSmkbTtGQwP1VeESgyBV+YUclmTCCdOI?=
 =?us-ascii?Q?w0vqXEAY125faxoRNQkER8PhKj207KCjK3U0vc5CUKTKM30WLvKva9o2kTJi?=
 =?us-ascii?Q?lH9ImXatqXcNu0Q/sYaJwRT7BHTN9ofr4zSrOI+IwUUTkYUo9WDtelI+DqJR?=
 =?us-ascii?Q?0L5FuFYZ+dJzgun3U+GSlin4rYtv4DX0VJBuaGNmbD/YrFwcdKxoJ78ttYOj?=
 =?us-ascii?Q?t1+aOi6IE2/fKMrVCYK12Sm8qTFrTo5pAJ9+gHPtpY33G60yWUz3RJctZKvl?=
 =?us-ascii?Q?EzkdOG+jNck13Gc9uhYmBs7AV0r3lkdJPte3rWHKUsB4hbVtojghtJ1HfJml?=
 =?us-ascii?Q?S6euQgSRLEDte414nfm5J+D4rUuD0fbB/U4MB/EsFQgaGGY93gMyGtDi1PVH?=
 =?us-ascii?Q?qo6F9yyWQHjWSLvLyFSQ/HQuUfjzSn6z4lU5nNbWkzF2NBkPKgxWeJ6oFt4b?=
 =?us-ascii?Q?5Q0eTr+4/cWDABbT5y0JG8T2Agy6uc3IA+9Lo8ZXE4qkvrflnte79MTN+vPY?=
 =?us-ascii?Q?nWL5WSS33meEtc56oN/UxI+kN53/0Z0K5g4MVo7WQBL9Ywrm+0vUNHhWZ9EQ?=
 =?us-ascii?Q?aMYzTbRB6nsI4mtin46fTiMbd5Gy6ioypkO/qOqZPdzeOW0PTuAuKFMF1JuU?=
 =?us-ascii?Q?qMp8NHwD15r6Kv13aeDZflkmA7Pk35hRMHtine6yA9Yn9G0zyrR563qFpadt?=
 =?us-ascii?Q?TM791Pj8GVDIShNZpbxGjlQNOkagurEYcIbF0pNvALphmVQbX0XPW6xL+Tw0?=
 =?us-ascii?Q?L8LDaT5Y4A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	f4U6tLS27Ke/zhuXCIypOZKytDugDhca+WpKK1iaO/T/vvDTda0Q0bGQCMJ5cvX091C+uKiuNiHYiWZwRJHOxSXV7WX1xweVQL82nLi+OBuYdefMRHnl5mC1YTwB/g/YXCvwyBW6vVpAJZqjt3WN7ndDYRmifGJncVd47jC4vq/QW+0CZoiXeh1MHFexOV2iVsLvmgcpzVTHOdk0QXjjac5un3O/6/NA9chuNmsX7s0g6AT770o6t5/GBIl1esCnYXqqnjr902QFqC0A6PpKr3KQdTvcOmtCrrP1XyAMSXnTPDqpa/OkaTlD6lYjb5IaERe1TV+0Im5Z/TiSTfOF6w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5619.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f00a06-6501-49f8-6526-08de83d30d3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 03:12:41.6252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajzjIqZDr3UmBUmcEj3p1UJJYWXBJNKzE0s+KdbHPthMQOvnW3kHxKXH8PQGfy8qooTzTTLabU9moliZFsWOREKQpD+0AhhPWi1/yLL/cno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR03MB8037
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69b8c6b8 cx=c_pps
 a=MVrca6uEa0E4C5ICDaep3Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ugNRTJOwpmtT476g4l8T:22 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=IyjSe8i7SjaciUra7ZIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: FP3NxPTJCU-sX1b86K871MfujPhqGxgj
X-Proofpoint-ORIG-GUID: FP3NxPTJCU-sX1b86K871MfujPhqGxgj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDAyNSBTYWx0ZWRfXw3yCn6ocmxU5
 eGeMPIB/mSztUjqb/LxHWoiJS5oEpJwz9Glj0ZVeXBofKCaGnuaa1jAR9dkrKXvhlY5/xjPGlwD
 sTnTr0egUMPKcZ92EFPRWG6a/YjOGWuNjUlPWebuMMiHvr0ueBbC2laVY90Fl4wZqeYjGiPN3FV
 LWPghG8MbAi7C26jLNTuPfgXWBHkepaIriWQt9nejJWASzfmJg716AlngrI2A0wA2BBZwfShMeM
 ZKEglQXwYt6KMeUyOyAD0/hYJojLWoUoLNikZpkwfa2epsGvBpfV9okQWRl7f2b638KHflIDVkg
 lS4RyaBo9+GmTRP4q2faJPlVSt4KSw5PJtrmWLcTBZ3iGl7m+xRcm0tUDaO3oLK6e0eKNwCYuoN
 dQkb+v2qEB09rJazyrshqDsp5MWVYDx19ZLBKUk5aDZOEWBGXyEqteI9YkNmhPpbP4/9wivdXuv
 y8Loc+XevoirYXeuwFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170025



> -----Original Message-----
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Sent: Wednesday, February 25, 2026 6:42 AM
> To: Sosa, Marc Paolo <MarcPaolo.Sosa@analog.com>
> Cc: Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; linux-
> input@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] input: misc: add driver for max16150
>=20
> [External]
>=20
> Hi Marc,
>=20
> On Mon, Feb 23, 2026 at 07:03:40PM +0800, Marc Paolo Sosa via B4 Relay
> wrote:
> > From: Marc Paolo Sosa <marcpaolo.sosa@analog.com>
> >
> > MAX16150/MAX16169 nanoPower Pushbutton On/Off Controller
> >
> > Signed-off-by: Marc Paolo Sosa <marcpaolo.sosa@analog.com>
> > ---
> >  drivers/input/misc/Kconfig    |   9 +++
> >  drivers/input/misc/Makefile   |   1 +
> >  drivers/input/misc/max16150.c | 161
> > ++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 171 insertions(+)
> >
> > diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> > index 94a753fcb64f..a31d3d2a7fd6 100644
> > --- a/drivers/input/misc/Kconfig
> > +++ b/drivers/input/misc/Kconfig
> > @@ -178,6 +178,15 @@ config INPUT_E3X0_BUTTON
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called e3x0_button.
> >
> > +config INPUT_MAX16150_PWRBUTTON
> > +	tristate "MAX16150/MAX16169 Pushbutton driver"
> > +	help
> > +	  Say Y here if you want to enable power key reporting via
> > +	  MAX16150/MAX16169 nanoPower Pushbutton On/Off Controller.
> > +
> > +	  To compile this driver as a module, choose M here. The module will
> > +	  be called max16150.
> > +
> >  config INPUT_PCSPKR
> >  	tristate "PC Speaker support"
> >  	depends on PCSPKR_PLATFORM
> > diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> > index 415fc4e2918b..c2c1c45f2df6 100644
> > --- a/drivers/input/misc/Makefile
> > +++ b/drivers/input/misc/Makefile
> > @@ -52,6 +52,7 @@ obj-$(CONFIG_INPUT_IQS7222)		+=3D iqs7222.o
> >  obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+=3D keyspan_remote.o
> >  obj-$(CONFIG_INPUT_KXTJ9)		+=3D kxtj9.o
> >  obj-$(CONFIG_INPUT_M68K_BEEP)		+=3D m68kspkr.o
> > +obj-$(CONFIG_INPUT_MAX16150_PWRBUTTON)	+=3D max16150.o
> >  obj-$(CONFIG_INPUT_MAX7360_ROTARY)	+=3D max7360-rotary.o
> >  obj-$(CONFIG_INPUT_MAX77650_ONKEY)	+=3D max77650-onkey.o
> >  obj-$(CONFIG_INPUT_MAX77693_HAPTIC)	+=3D max77693-haptic.o
> > diff --git a/drivers/input/misc/max16150.c
> > b/drivers/input/misc/max16150.c new file mode 100644 index
> > 000000000000..ae353b926afc
> > --- /dev/null
> > +++ b/drivers/input/misc/max16150.c
> > @@ -0,0 +1,161 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Analog Devices MAX16150/MAX16169 Pushbutton Driver
> > + *
> > + * Copyright 2025 Analog Devices Inc.
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/init.h>
> > +#include <linux/input.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +
> > +#define MAX16150_LONG_INTERRUPT 120000000
> > +
> > +struct max16150_chip_info {
> > +	bool has_clr_gpio;
> > +};
> > +
> > +struct max16150_device {
> > +	struct input_dev *input;
> > +	struct gpio_desc *gpiod;
> > +	struct gpio_desc *clr_gpiod;
> > +	const struct max16150_chip_info *chip_info;
> > +	u64 low, high, duration;
>=20
> I do not think you need to store "high" and "duration", just "press"
> time. I also do not think you need nanosecond resilution, jiffies will do=
.
>=20
> > +	unsigned int keycode;
> > +};
> > +
> > +static irqreturn_t max16150_irq_handler(int irq, void *_max16150) {
> > +	struct max16150_device *max16150 =3D _max16150;
> > +	int value;
> > +
> > +	value =3D gpiod_get_value(max16150->gpiod);
> > +
> > +	if (!value) {
> > +		max16150->low =3D ktime_get_ns();
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	max16150->high =3D ktime_get_ns();
> > +	if (max16150->low) {
> > +		max16150->duration =3D max16150->high - max16150->low;
> > +
> > +		if (max16150->duration > MAX16150_LONG_INTERRUPT) {
>=20
> time_after() is probably what you need here.
>=20
> > +			gpiod_set_value(max16150->clr_gpiod, 1);
> > +			input_report_key(max16150->input, max16150-
> >keycode, 1);
> > +			input_sync(max16150->input);
>=20
> Why is press not reported right away?
>=20
> > +			input_report_key(max16150->input, max16150-
> >keycode, 0);
> > +			input_sync(max16150->input);
> > +		}
> > +
> > +		max16150->low =3D 0;
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static const struct max16150_chip_info max16150_variant_a =3D {
> > +	.has_clr_gpio =3D true,
> > +};
> > +
> > +static const struct max16150_chip_info max16150_variant_b =3D {
> > +	.has_clr_gpio =3D false,
> > +};
> > +
> > +static int max16150_probe(struct platform_device *pdev) {
> > +	const struct max16150_chip_info *chip_info;
> > +	struct max16150_device *max16150;
> > +	struct device *dev =3D &pdev->dev;
> > +	int err, irq, ret;
>=20
> Why do you need both err and ret?
>=20
> > +	u32 keycode;
> > +
> > +	chip_info =3D device_get_match_data(dev);
> > +	if (!chip_info)
> > +		return -EINVAL;
> > +
> > +	max16150 =3D devm_kzalloc(dev, sizeof(*max16150), GFP_KERNEL);
> > +	if (!max16150)
> > +		return -ENOMEM;
> > +
> > +	max16150->chip_info =3D chip_info;
> > +
> > +	max16150->input =3D devm_input_allocate_device(dev);
> > +	if (!max16150->input)
> > +		return -ENOMEM;
> > +
> > +	max16150->input->name =3D "MAX16150 Pushbutton";
> > +	max16150->input->phys =3D "max16150/input0";
> > +	max16150->input->id.bustype =3D BUS_HOST;
> > +
> > +	keycode =3D KEY_POWER;
> > +	ret =3D device_property_read_u32(dev, "linux,code", &keycode);
>=20
> 	err =3D ...
>=20
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to get keycode\n");
> > +
> > +	max16150->keycode =3D keycode;
> > +
> > +	input_set_capability(max16150->input, EV_KEY, max16150->keycode);
> > +
> > +	max16150->gpiod =3D devm_gpiod_get(dev, "interrupt", GPIOD_IN);
> > +	if (IS_ERR(max16150->gpiod))
> > +		return dev_err_probe(dev, PTR_ERR(max16150->gpiod),
> > +				     "Failed to get interrupt GPIO\n");
> > +
> > +	if (chip_info->has_clr_gpio) {
> > +		max16150->clr_gpiod =3D devm_gpiod_get(dev, "clr",
> GPIOD_OUT_HIGH);
> > +		if (IS_ERR(max16150->clr_gpiod))
> > +			return dev_err_probe(dev, PTR_ERR(max16150-
> >clr_gpiod),
> > +					     "Failed to get clr GPIO\n");
> > +
> > +		if (!max16150->clr_gpiod)
>=20
>=20
> How would we end up here? You are using devm_gpiod_get() which will never
> return NULL GPIO descriptor.
>=20
> > +			return dev_err_probe(dev, -ENODEV,
> > +						 "clr GPIO is mandatory\n");
> > +
> > +		if (max16150->clr_gpiod) {
> > +			fsleep(1000);
> > +			gpiod_set_value(max16150->clr_gpiod, 0);
> > +		}
> > +	}
> > +
> > +	irq =3D gpiod_to_irq(max16150->gpiod);
> > +	if (irq < 0)
> > +		return dev_err_probe(dev, irq,
> > +				     "MAX16150: Failed to map GPIO to IRQ");
>=20
> As Rob said in DT binding review use interrupts property and separate IRQ=
 and
> GPIO handling.
>=20
> > +
> > +	err =3D devm_request_irq(dev, irq, max16150_irq_handler,
> > +			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> > +			       "max16150_irq", max16150);
> > +	if (err)
> > +		return err;
> > +
> > +	return input_register_device(max16150->input);
>=20
> 	err =3D input_register_device(...);
> 	if (err)
> 		return err;
>=20
> 	return 0;
>=20
> > +}
> > +
> > +static const struct of_device_id max16150_of_match[] =3D {
> > +	{ .compatible =3D "adi,max16150a", .data =3D &max16150_variant_a },
> > +	{ .compatible =3D "adi,max16150b", .data =3D &max16150_variant_b },
> > +	{ .compatible =3D "adi,max16169a", .data =3D &max16150_variant_a },
> > +	{ .compatible =3D "adi,max16169b", .data =3D &max16150_variant_b },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, max16150_of_match);
> > +
> > +static struct platform_driver max16150_driver =3D {
> > +	.probe  =3D max16150_probe,
> > +	.driver =3D {
> > +		.name =3D "max16150",
> > +		.of_match_table =3D max16150_of_match,
> > +	},
> > +};
> > +module_platform_driver(max16150_driver);
> > +
> > +MODULE_AUTHOR("Marc Paolo Sosa <marcpaolo.sosa@analog.com>");
> > +MODULE_DESCRIPTION("MAX16150/MAX16169 Pushbutton Driver");
> > +MODULE_LICENSE("GPL");
>=20


Thank you for the initial review, I'll test the ff suggestions above and ap=
ply it to V2, for summary,

  1. Switch from nanoseconds to jiffies with single press_time variable and
  time_after() for comparison
  2. Remove redundant err/ret variables and use consistent naming
  3. Remove impossible NULL checks after devm_gpiod_get() since it never re=
turns NULL
  4. Fix device_property_read_u32() error handling since linux,code is opti=
onal with
  default
  5. Use explicit error checking pattern instead of implicit return
  6. The MAX16150's OUT pin serves dual purposes (interrupt + GPIO state re=
ading) -
  should I use separate 'interrupts' and 'out-gpios' properties for the sam=
e physical pin, or is there a
  preferred approach for this hardware design?
  7. The duration measurement is needed since the device ignores short pres=
ses, but I could
   report press immediately and validate on release instead

  I'll send v2 with these improvements once I clarify the preferred IRQ/GPI=
O handling approach.

Best regards,
Pao
