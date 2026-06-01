Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384301F0E29;
	Mon,  1 Jun 2026 03:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780284298; cv=fail; b=GD4NZofzP1r51Y3QXORG/PsgkDDbnUM32otAx+pQg4IJyKv6yhrvJbk5aGmIbUuZIqmAtM1wL90j4l0cJtrFFoYLhtjgIeMj4gsChg1h3HJNOJAqYZSY48PfXDhdH5D+Hqi+A0USxnbZ9AGgKt/O5ir1pCIaEo4+vhAkEAak2MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780284298; c=relaxed/simple;
	bh=NmDxVhxGoju0TbmbNu+eLRSQFy3va47cB0HGK6n74hQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qnvrha27no9hegI68qJhNl5h3sFRnKGLwbAB+HkdzHpuJ9/B2ApdYPJGcZEeTJSEM/izvdQtfi6dEUCpdjiQO7Lqh8fgQeagWw4k+EZxyjqcuBpwhIhF1cUZoylwAsbIf5ZmBUOPnhWRYch5dFH8qcXiQZVvMvVs5TzoJ3NKThk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpVZjE1E; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpVZjE1E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780284296; x=1811820296;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=NmDxVhxGoju0TbmbNu+eLRSQFy3va47cB0HGK6n74hQ=;
  b=mpVZjE1EEFsUTT57k+vLtM4P2VR9dDB06wDAbUTuE59gvWf6QKWWB83C
   hkvhqf093IjiTchtnXjABWv2e9fZhN1yDGAX4GGWuZEvrN7vvV+n3pj5d
   GZ+qZMllSg+iM1uxJWFipiRTyPCOoZo0qYZJ2ManjnPJ8hplkXGW5eT2i
   Y7TYL7H3r2e/b1sPOTMkzYE2dp1IRFF1jRPM6lDra4p7BB3SRxWxzKf4y
   2x9EBN6BY2dOFDku6YRsqjNTMboGFDtwBF4FzLhvzj8lQ/t57NSQM+qlC
   3+0FEFfALWWvbRDRG+UOKcGscrDftvWOJQpHBBRvSNQaIrqrICwbsq498
   A==;
X-CSE-ConnectionGUID: Z66KukIiSPGdMoOXSPIAgg==
X-CSE-MsgGUID: r0ao/uPyTTe9oUVgwTIvRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="91719550"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208,223";a="91719550"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 20:24:55 -0700
X-CSE-ConnectionGUID: IVKZTgeNRO2jZr0CBMLW3w==
X-CSE-MsgGUID: qcgYhdIaT1a5R1G1GiJzLQ==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 20:24:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 31 May 2026 20:24:55 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 31 May 2026 20:24:55 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 31 May 2026 20:24:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOzB8ihVWTOwBSB5vvIK+1cbw+S9xGkbP/IOn4RxHsOhskTDfTXh97dtqiejcdMdJ3IRbyZdQNR8EDSuPnu681iOmYHFlsw30D5rlc6QpfX2P7EPmUdN8yCS6f10SqeNBw3SiENg3pnAT3SBpafyp1E53jB8QR6WDNDlv3o9KPSk6l/9aNhjFRci37UqmY4MWdXDKB2yJpbocVIqpytgRRDkjpPgPVmuNc2tC+7Gtlkq89s03OL0HoHBWwPF/610RnPTqtb6BSW2H5f6vq175CpBcv0Oi5NXHMhAt3R7vflRJuwtEMjYYxiU9rtfZRlnknVjZmJqUi2xfh0aBDcWZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znZHjWJWMAk+621HreourswXnAwW7PdZZ6QkYYwxWCM=;
 b=dkFb1C1UDrg0+bpZjvkU7T37Ks8dqIan51ODmF8+4BmCcdx3NU8I2cAYs/3WIKLOyFz7DGam3mUlzv9KnsS9ZW4+UYgc1gFtArk73zpo9+2/EfyQS+BdavEuG8WggZZjlUaxx5gBeARvObzEShxBpFzhg2wHyqNyfq8cLOTiS/lxAJPj23pEB1WfPt+fvaNMnrhDQSpYold7XFf5urL9vmVgrZXLOoqj2+ZmHE92ChBNTjdD9/W/95WH7UeFcdaB0vMw3d4VDfpVuVLXinQjJxyagjkZ+CCp4sLZVLqUrKbj/8/aSbpqvoZ8iM+WrANJ35f820sT5UBvr1GJkT1w7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by DS0PR11MB8052.namprd11.prod.outlook.com (2603:10b6:8:122::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 03:24:53 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%4]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 03:24:53 +0000
From: "Xu, Even" <even.xu@intel.com>
To: d3z-the-dev <d3z.the.dev@gmail.com>, "Sun, Xinpeng"
	<xinpeng.sun@intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<bentiss@kernel.org>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Abhishek
 Tamboli" <abhishektamboli9@gmail.com>, Sakari Ailus
	<sakari.ailus@linux.intel.com>
Subject: RE: [PATCH] HID: intel-thc-hid: intel-quickspi: reset touch IC on
 system resume
Thread-Topic: [PATCH] HID: intel-thc-hid: intel-quickspi: reset touch IC on
 system resume
Thread-Index: AQHc77mrUbJCsvCWBk+2B+n2qvQl/bYpBmKg
Date: Mon, 1 Jun 2026 03:24:52 +0000
Message-ID: <IA1PR11MB60987CB2D72FD1701951DFA4F4152@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260529222210.1532876-1-d3z.the.dev@gmail.com>
In-Reply-To: <20260529222210.1532876-1-d3z.the.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|DS0PR11MB8052:EE_
x-ms-office365-filtering-correlation-id: 8f85e1d1-c418-4cd5-14f8-08debf8d5887
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|6049299003|6133799003|22082099003|18002099003|3023799007|11063799006|56012099006|38070700021|4053099003;
x-microsoft-antispam-message-info: RjRbhJo1xDx08qZ5jOvQIaePkxObIuLMdKYZdPKPYY1EeWtd3qTkcdtwI4kANrz9plDcg/jGuYja8GJXQoCRDRmSl+HsgGU71NiI8o03F7bpOzTQgI5wCgQGquonhhvVSNGZSES25n2dxspbqxc9aoFfS0CpV84sajv7aomn9AIuflT2lOETrtdmN4tNf2tzn0YVUL0uv8t4OCIPpZUISVuLjvC564ogUXNXlz2pP6ur7ZKQ6RLajRSHQgBrxO53VZ8Hu+SQeMQfYiafSVyE45WhP7OqK9BDAtbHiO2Tm9cfcyssvA082jJ3NQxT5LqnI1z9WD/Gt6uHMiMGkwn97/jCNEptvav4VznIHXx+ceTBOTtJUoMx0secMquWJVW2IAs1V21apaEAQE/BRr63krZVGc+a5gD/9QEtkx4oK1GJN/LCMYzcFHF3wtOgQq1m52kMMXqKaleZRo2JYn78JX9CTkZ6ete8BiiBH96nThNlgjs9gXCzsd/5amXriq/UvquJfXPQOV+80WD65v75kl7ryrIsbqVvdymrLgeWoBRnqUYgqSTm9oz+CH29X4l198J3X8ma9BSnnb5bo43BmCjpmNG92XJcNPdXVEIHmX6uUCPjEC3lMeAyCGl3aObitY/vxcAOZpZOyFWlq07Aq/mqL4d/0XO2IXvrZPuBqllNYa+dU82PRB7fWRYCxlyZoB0crhfHtFZteyG8JzEZJ2TCNsD6ZstA8/HafJ3utdKe2DjgO/SeyDXLdiRfYcyK1ZMpx0c2eGySa8vIsalcDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(6049299003)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(38070700021)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LMVpJD/XAGxb8+wscs7fdOMELLan8/DVHOWqxdQqnBC1Z0AyI2aEKseLNVdH?=
 =?us-ascii?Q?NWI0UYhBRpZgHaFi7dKJyP3Hi+viV08CvEhqbzZXAFRF8I+CPvkzaB4Apof1?=
 =?us-ascii?Q?WqhZQHOeP8IYrLxQI26lqntigZsVzK2AaG2B1s1W0PKDFXhuNPtGY+K3Dht9?=
 =?us-ascii?Q?nOPgiBbrYfBsBg/LhH2oqSVTrPkKWwJspferBPGlE2dMxzkYuQrGH/HZoq9O?=
 =?us-ascii?Q?hs5BsPdzhEIo5WpTR3DorKhjIu878FTaXC0zXvmt1IFjix7w2sRZ2xy05B6r?=
 =?us-ascii?Q?ZUe1xt+DowF1w06RnKjkiogvozTLnGznWri6kzbomkDSAvYMjpGeyk+tp9v4?=
 =?us-ascii?Q?sIhadwE3ufApxvapUsH9jiz1jAlYLNxn+8MaI1zINQHABUm65kL2HMZw6pW0?=
 =?us-ascii?Q?Ni/jp3b2DQXGKfywf5bTYHNFmwuhsODb2n501dLtEeTX490qKHFMwZHH2o7S?=
 =?us-ascii?Q?jditOPVbg+vgl/6BRv+DaY/T+GqohZKrFyqTCTXL1SlO4L2SUR6hNx0tlwlC?=
 =?us-ascii?Q?xtBjbZJHHee5m64csKxsIuLS5gIvlzUvRk9z+Zro1i9nPH6Lid88aZNAs/nr?=
 =?us-ascii?Q?VkU+kCDi5CjUKrcDpAH1ni/bMEkgILndzc69cksi4JD1pZA9P0agL96AIaQz?=
 =?us-ascii?Q?VHj37EvjVE8dYFqGaj9KmotZL6qOvKUmPscqHGhf6mefS710HjZcET5A5FA8?=
 =?us-ascii?Q?WtdhRffIx2gNSrvut9/5LtGCAO80WOQwVBdgN6mRFBV3kXa/bHSRiJSMc2HI?=
 =?us-ascii?Q?GyuP01n14uxlVGGfBSUHk0D1hBSPJRbOq7KnRk0zJkEldPoQhGe/Q1z8iVR+?=
 =?us-ascii?Q?dnEueiGpTlcqLHh2gu+SS5hoXgEb2wxg+aSOQBxHlxS9j1aBh2ftbkRPjyRm?=
 =?us-ascii?Q?jH1YW9InxAM/u9Xi6sWbbNGFgPXTzPjtlCpSInM/e51UapGRJQryv2mHbMrr?=
 =?us-ascii?Q?UccQkdnZm28wTW3Qr84EDVbeBTkcLbNdcKKHdvON1t3xtVV6IIrL+cQjEmx0?=
 =?us-ascii?Q?FomVpGB3RSDn5wYiPLxA8+cSz/GEID3AM3p1uUvoKQPZx2OK1H3Reo3y22QN?=
 =?us-ascii?Q?j5kJCJX4SUEXIjE1bCiVI+a+BpHmunCoH8SGIdpHVBQm2zf/C0VfsEwngAZz?=
 =?us-ascii?Q?ZXRp73ssQiDfuLhogsIfKcbPO0GzAUoWndUbMpxGUb/qBznWKUS0iO2sHri5?=
 =?us-ascii?Q?T6Ljd6PFkxSf9gQdFrk+XLKzwYWpm19OjchHdKzteHvV/Tc1pJ8YoEvtXs/K?=
 =?us-ascii?Q?8rFT3DlkmEdZ6/a7Bu/GblFIW5YNwBbcEyvIxDOya5T+ri7hKBKqOoXNBSwf?=
 =?us-ascii?Q?0kv32jCPkMwsMZp9qYaJV2WtmcmNGFxWAZm+Q9NPyzB5YWz/GJQPSYwwyVwN?=
 =?us-ascii?Q?5ttJKEf9T1qLaFIEcaMAO/1nsm6FN4Gh7jhnZxzcQrElkPywa3ng7mMwUnme?=
 =?us-ascii?Q?xYe8lZ6/NJI8vRSpBenzqyPvUIKYZddj8xcJaAl7BZZ1u7/5AjmbL0sHkBc1?=
 =?us-ascii?Q?3N5Xf/dEPrnHUR708yi69ksNZGkw1F1B+m6cz1fk71K68CfdKCeQHul/1Jiw?=
 =?us-ascii?Q?Egn+VG2hn2+viml6o/w9TKM2MGyyDh42dyqnE84IWJAonvTQITaYPmoW6upP?=
 =?us-ascii?Q?6L70D6uB4P+GJ9cI4fGoQBCqc5/Udvx03IwStpoNO2BZbmbpviSiIdk//mmG?=
 =?us-ascii?Q?U8xKukP7Up7sGlLIw0bm8MICiSDTde9rZI8ivFQ5pxBBaKZ0?=
Content-Type: multipart/mixed;
	boundary="_002_IA1PR11MB60987CB2D72FD1701951DFA4F4152IA1PR11MB6098namp_"
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cuX+OWGay7FCFfhHlaF+rHInznKr9xCpB6N+xx1AZsCJhK9a4RUyXRzP4FQtKbSExsy19SnxLQHdV3oEtzafePUiT9pH4RSyU6UqzvyENa1UhLW2BDuzEr8C8u8JTSMoUjB05YN+RUQvS+1jnwrvWHirA8UDDojOZF9Fb8UZFYk5wHXPk5NW9Uodr57DBeI+/oslHEJHOoZ90lQQ/Sjzk/0Ui0B/txpDS+uySkhiUeIVhldd3YSsybbJTHfKGBTZNI+f951prSlVvsMdk7X6TN+tP0+HvE9NXA1+4ORsgQ/eQ6PKN2Yiu0kI2vDJz4Q/8yeFY1l7Nz+HwakJf0XR0w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f85e1d1-c418-4cd5-14f8-08debf8d5887
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 03:24:52.8977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MdXJ5x5w3KUFeCwpFLLNre3twvqvDivDowKt0yCJaJFaKM4Bg6H+WyXIzg5/16dNPqVxo5XQuX5l2hhm2hmsoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8052
X-OriginatorOrg: intel.com

--_002_IA1PR11MB60987CB2D72FD1701951DFA4F4152IA1PR11MB6098namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,=20

Sorry, I cannot get your exact name from this patch email.

From your issue description, I suppose Surface Pro 10 uses "Suspend-to-RAM"=
 instead of "Standby" or "Suspend-to-Idle" for suspend/resume.
As this documents mentioned, driver needs to take care the suspend type the=
n handle resume flow carefully.

Actually, I had a patch for this "Suspend-to-RAM" support several months ag=
o, please find attached file for the patch. This patch is still under our i=
nternal final validation.

It will be very appreciated if you can help test attached patch on your Sur=
face device.
If it works, then everything is fine, I will submit this patch with your na=
me after our final validation.
If it doesn't work for your case, then we need to future debug on your surf=
ace device to refine your patch to let it more standard.

Thanks!

Best Regards,
Even Xu

> -----Original Message-----
> From: d3z-the-dev <d3z.the.dev@gmail.com>
> Sent: Saturday, May 30, 2026 6:22 AM
> To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>; J=
iri
> Kosina <jikos@kernel.org>; Benjamin Tissoires <bentiss@kernel.org>
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Abhishek T=
amboli
> <abhishektamboli9@gmail.com>; Sakari Ailus <sakari.ailus@linux.intel.com>=
;
> d3z-the-dev <d3z.the.dev@gmail.com>
> Subject: [PATCH] HID: intel-thc-hid: intel-quickspi: reset touch IC on sy=
stem
> resume
>=20
> On the Surface Pro 10 (Meteor Lake) the touchscreen stops working after a
> suspend/resume cycle and only recovers after a reboot. The driver logs
> "GET_DEVICE_INFO: recv failed: -11" on resume.
>=20
> The touch IC loses power during system suspend (s2idle) on this platform,=
 the
> same way it does across hibernation. quickspi_resume() only restores the =
THC
> port, interrupts and DMA and sends a HIDSPI_ON command, assuming the touc=
h
> IC kept its power and state. When it has actually lost power the HIDSPI_O=
N
> command is never acknowledged and the descriptor read fails, leaving the
> touchscreen dead until the module is reloaded.
>=20
> quickspi_restore() already handles this for hibernation by running
> reset_tic() and reconfiguring the THC SPI/LTR settings. Make
> quickspi_resume() do the same: quiesce interrupts, re-select the THC port=
,
> reconfigure the SPI input/output addresses and read/write parameters, run
> reset_tic() to re-enumerate the device and restore the LTR configuration.
>=20
> Tested on a Surface Pro 10 across multiple s2idle suspend/resume cycles.
>=20
> Link: https://github.com/linux-surface/linux-surface/issues/1799
>=20
> Signed-off-by: d3z-the-dev <d3z.the.dev@gmail.com>
> ---
>  .../intel-quickspi/pci-quickspi.c             | 38 +++++++++++++++++--
>  1 file changed, 34 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index f669235f1883..d59278a3e5c1 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> @@ -780,24 +780,54 @@ static int quickspi_resume(struct device *device)
>  	if (!qsdev)
>  		return -ENODEV;
>=20
> +	ret =3D thc_interrupt_quiesce(qsdev->thc_hw, true);
> +	if (ret)
> +		return ret;
> +
>  	ret =3D thc_port_select(qsdev->thc_hw, THC_PORT_TYPE_SPI);
>  	if (ret)
>  		return ret;
>=20
> +	thc_spi_input_output_address_config(qsdev->thc_hw,
> +					    qsdev->input_report_hdr_addr,
> +					    qsdev->input_report_bdy_addr,
> +					    qsdev->output_report_addr);
> +
> +	ret =3D thc_spi_read_config(qsdev->thc_hw, qsdev->spi_freq_val,
> +				  qsdev->spi_read_io_mode,
> +				  qsdev->spi_read_opcode,
> +				  qsdev->spi_packet_size);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D thc_spi_write_config(qsdev->thc_hw, qsdev->spi_freq_val,
> +				   qsdev->spi_write_io_mode,
> +				   qsdev->spi_write_opcode,
> +				   qsdev->spi_packet_size,
> +				   qsdev->performance_limit);
> +	if (ret)
> +		return ret;
> +
>  	thc_interrupt_config(qsdev->thc_hw);
>=20
>  	thc_interrupt_enable(qsdev->thc_hw, true);
>=20
> -	ret =3D thc_dma_configure(qsdev->thc_hw);
> +	/* The TIC may lose power across system suspend, reset it to recover */
> +	ret =3D reset_tic(qsdev);
>  	if (ret)
>  		return ret;
>=20
> -	ret =3D thc_interrupt_quiesce(qsdev->thc_hw, false);
> +	ret =3D thc_dma_configure(qsdev->thc_hw);
>  	if (ret)
>  		return ret;
>=20
> -	if (!device_may_wakeup(qsdev->dev))
> -		return quickspi_set_power(qsdev, HIDSPI_ON);
> +	thc_ltr_config(qsdev->thc_hw,
> +		       qsdev->active_ltr_val,
> +		       qsdev->low_power_ltr_val);
> +
> +	thc_change_ltr_mode(qsdev->thc_hw, THC_LTR_MODE_ACTIVE);
> +
> +	qsdev->state =3D QUICKSPI_ENABLED;
>=20
>  	return 0;
>  }
> --
> 2.54.0


--_002_IA1PR11MB60987CB2D72FD1701951DFA4F4152IA1PR11MB6098namp_
Content-Type: application/octet-stream;
	name="0001-Hid-Intel-thc-hid-Intel-quickspi-Fix-non-functional-.patch"
Content-Description: 0001-Hid-Intel-thc-hid-Intel-quickspi-Fix-non-functional-.patch
Content-Disposition: attachment;
	filename="0001-Hid-Intel-thc-hid-Intel-quickspi-Fix-non-functional-.patch";
	size=3337; creation-date="Mon, 01 Jun 2026 03:16:52 GMT";
	modification-date="Mon, 01 Jun 2026 03:24:52 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5MzllYzJjNDkxZjc4OWI1Yjc0MGE1ODkzNmZmMGUwNGNiNzFkMmE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFdmVuIFh1IDxldmVuLnh1QGludGVsLmNvbT4KRGF0ZTogTW9u
LCAxOSBKYW4gMjAyNiAxNjoxNjoxMiArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEhpZDogSW50ZWwt
dGhjLWhpZDogSW50ZWwtcXVpY2tzcGk6IEZpeCBub24tZnVuY3Rpb25hbCB0b3VjaAogYWZ0ZXIg
UzMgcmVzdW1lCgpUSEMgaGFyZHdhcmUgcmVnaXN0ZXJzIGxvc2UgdGhlaXIgY29udGVudCBkdXJp
bmcgUzMgc3VzcGVuZC4gQWRkIGhhcmR3YXJlCnJlY29uZmlndXJhdGlvbiBvbiByZXN1bWUgZnJv
bSBTMyB0byByZXN0b3JlIHRvdWNoIGZ1bmN0aW9uYWxpdHkuCgpTaWduZWQtb2ZmLWJ5OiBFdmVu
IFh1IDxldmVuLnh1QGludGVsLmNvbT4KLS0tCiAuLi4vaW50ZWwtcXVpY2tzcGkvcGNpLXF1aWNr
c3BpLmMgICAgICAgICAgICAgfCAzMiArKysrKysrKysrKysrKysrKysrCiAuLi4vaW50ZWwtcXVp
Y2tzcGkvcXVpY2tzcGktZGV2LmggICAgICAgICAgICAgfCAgNCArKysKIDIgZmlsZXMgY2hhbmdl
ZCwgMzYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL2ludGVsLXRoYy1o
aWQvaW50ZWwtcXVpY2tzcGkvcGNpLXF1aWNrc3BpLmMgYi9kcml2ZXJzL2hpZC9pbnRlbC10aGMt
aGlkL2ludGVsLXF1aWNrc3BpL3BjaS1xdWlja3NwaS5jCmluZGV4IDIwZThkYmYxZDMxMy4uMGQ2
N2EwYmIyZWU3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2hpZC9pbnRlbC10aGMtaGlkL2ludGVsLXF1
aWNrc3BpL3BjaS1xdWlja3NwaS5jCisrKyBiL2RyaXZlcnMvaGlkL2ludGVsLXRoYy1oaWQvaW50
ZWwtcXVpY2tzcGkvcGNpLXF1aWNrc3BpLmMKQEAgLTEwLDYgKzEwLDcgQEAKICNpbmNsdWRlIDxs
aW51eC9pcnFyZXR1cm4uaD4KICNpbmNsdWRlIDxsaW51eC9wY2kuaD4KICNpbmNsdWRlIDxsaW51
eC9wbV9ydW50aW1lLmg+CisjaW5jbHVkZSA8bGludXgvc3VzcGVuZC5oPgogCiAjaW5jbHVkZSA8
bGludXgvZ3Bpby9jb25zdW1lci5oPgogCkBAIC03NjUsNiArNzY2LDggQEAgc3RhdGljIGludCBx
dWlja3NwaV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldmljZSkKIAogCXRoY19kbWFfdW5jb25m
aWd1cmUocXNkZXYtPnRoY19odyk7CiAKKwlxc2Rldi0+bGFzdF9zdXNwZW5kX3N0YXRlID0gcG1f
c3VzcGVuZF90YXJnZXRfc3RhdGU7CisKIAlyZXR1cm4gMDsKIH0KIApAQCAtNzgyLDYgKzc4NSwz
NSBAQCBzdGF0aWMgaW50IHF1aWNrc3BpX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXZpY2UpCiAJ
aWYgKHJldCkKIAkJcmV0dXJuIHJldDsKIAorCS8qIElmIGl0J3MgcmVzdW1lIGZyb20gUzMsIG5l
ZWQgdG8gcmUtY29uZmlndXJlIFNQSSBwb3J0ICovCisJaWYgKHFzZGV2LT5sYXN0X3N1c3BlbmRf
c3RhdGUgPT0gUE1fU1VTUEVORF9NRU0pIHsKKwkJdGhjX3NwaV9pbnB1dF9vdXRwdXRfYWRkcmVz
c19jb25maWcocXNkZXYtPnRoY19odywKKwkJCQkJCSAgICBxc2Rldi0+aW5wdXRfcmVwb3J0X2hk
cl9hZGRyLAorCQkJCQkJICAgIHFzZGV2LT5pbnB1dF9yZXBvcnRfYmR5X2FkZHIsCisJCQkJCQkg
ICAgcXNkZXYtPm91dHB1dF9yZXBvcnRfYWRkcik7CisKKwkJcmV0ID0gdGhjX3NwaV9yZWFkX2Nv
bmZpZyhxc2Rldi0+dGhjX2h3LCBxc2Rldi0+c3BpX2ZyZXFfdmFsLAorCQkJCQkgIHFzZGV2LT5z
cGlfcmVhZF9pb19tb2RlLAorCQkJCQkgIHFzZGV2LT5zcGlfcmVhZF9vcGNvZGUsCisJCQkJCSAg
cXNkZXYtPnNwaV9wYWNrZXRfc2l6ZSk7CisJCWlmIChyZXQpCisJCQlyZXR1cm4gcmV0OworCisJ
CXJldCA9IHRoY19zcGlfd3JpdGVfY29uZmlnKHFzZGV2LT50aGNfaHcsIHFzZGV2LT5zcGlfZnJl
cV92YWwsCisJCQkJCSAgIHFzZGV2LT5zcGlfd3JpdGVfaW9fbW9kZSwKKwkJCQkJICAgcXNkZXYt
PnNwaV93cml0ZV9vcGNvZGUsCisJCQkJCSAgIHFzZGV2LT5zcGlfcGFja2V0X3NpemUsCisJCQkJ
CSAgIHFzZGV2LT5wZXJmb3JtYW5jZV9saW1pdCk7CisJCWlmIChyZXQpCisJCQlyZXR1cm4gcmV0
OworCisJCXRoY19sdHJfY29uZmlnKHFzZGV2LT50aGNfaHcsCisJCQkgICAgICAgcXNkZXYtPmFj
dGl2ZV9sdHJfdmFsLAorCQkJICAgICAgIHFzZGV2LT5sb3dfcG93ZXJfbHRyX3ZhbCk7CisKKwkJ
dGhjX2NoYW5nZV9sdHJfbW9kZShxc2Rldi0+dGhjX2h3LCBUSENfTFRSX01PREVfQUNUSVZFKTsK
Kwl9CisKIAl0aGNfaW50ZXJydXB0X2NvbmZpZyhxc2Rldi0+dGhjX2h3KTsKIAogCXRoY19pbnRl
cnJ1cHRfZW5hYmxlKHFzZGV2LT50aGNfaHcsIHRydWUpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9o
aWQvaW50ZWwtdGhjLWhpZC9pbnRlbC1xdWlja3NwaS9xdWlja3NwaS1kZXYuaCBiL2RyaXZlcnMv
aGlkL2ludGVsLXRoYy1oaWQvaW50ZWwtcXVpY2tzcGkvcXVpY2tzcGktZGV2LmgKaW5kZXggZWY0
MzNmZTFiNDVkLi4zYmVlZWM2MmRkMDkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaGlkL2ludGVsLXRo
Yy1oaWQvaW50ZWwtcXVpY2tzcGkvcXVpY2tzcGktZGV2LmgKKysrIGIvZHJpdmVycy9oaWQvaW50
ZWwtdGhjLWhpZC9pbnRlbC1xdWlja3NwaS9xdWlja3NwaS1kZXYuaApAQCAtNyw2ICs3LDcgQEAK
ICNpbmNsdWRlIDxsaW51eC9iaXRzLmg+CiAjaW5jbHVkZSA8bGludXgvaGlkLW92ZXItc3BpLmg+
CiAjaW5jbHVkZSA8bGludXgvc2l6ZXMuaD4KKyNpbmNsdWRlIDxsaW51eC9zdXNwZW5kLmg+CiAj
aW5jbHVkZSA8bGludXgvd2FpdC5oPgogCiAjaW5jbHVkZSAicXVpY2tzcGktcHJvdG9jb2wuaCIK
QEAgLTEyNCw2ICsxMjUsNyBAQCBzdHJ1Y3QgYWNwaV9kZXZpY2U7CiAgKiBAZ2V0X2ZlYXR1cmVf
Y21wbDogaW5kaWNhdGUgZ2V0IGZlYXR1cmUgcmVjZWl2ZWQgb3Igbm90CiAgKiBAc2V0X2ZlYXR1
cmVfY21wbF93cTogd29ya3F1ZXVlIGZvciB3YWl0aW5nIHNldCBmZWF0dXJlIHRvIGRldmljZQog
ICogQHNldF9mZWF0dXJlX2NtcGw6IGluZGljYXRlIHNldCBmZWF0dXJlIHNlbmQgY29tcGxldGUg
b3Igbm90CisgKiBAbGFzdF9zdXNwZW5kX3N0YXRlOiBzYXZlIGxhc3Qgc3lzdGVtIHN1c3BlbmQg
c3RhdGUKICAqLwogc3RydWN0IHF1aWNrc3BpX2RldmljZSB7CiAJc3RydWN0IGRldmljZSAqZGV2
OwpAQCAtMTcxLDYgKzE3Myw4IEBAIHN0cnVjdCBxdWlja3NwaV9kZXZpY2UgewogCiAJd2FpdF9x
dWV1ZV9oZWFkX3Qgc2V0X3JlcG9ydF9jbXBsX3dxOwogCWJvb2wgc2V0X3JlcG9ydF9jbXBsOwor
CisJc3VzcGVuZF9zdGF0ZV90IGxhc3Rfc3VzcGVuZF9zdGF0ZTsKIH07CiAKICNlbmRpZiAvKiBf
UVVJQ0tTUElfREVWX0hfICovCi0tIAoyLjQzLjAKCg==

--_002_IA1PR11MB60987CB2D72FD1701951DFA4F4152IA1PR11MB6098namp_--
