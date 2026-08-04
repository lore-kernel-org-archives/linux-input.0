Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F13BD643;
	Tue,  4 Aug 2026 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785805312; cv=fail; b=rD9AZYrWecf9pTkOkRgICtDvDOKUDfj0tVNTXEAwcfJS8OVg7gLaPE52aE8M9uRCBP7stuHeCpkPV0kjoqDNtGIIwqll20x645IypfQkjHrGrKdMFn4DW9vQ4ntX52kMHF2r9M0jTtS2uqg/xFdlxMmgVLtZUXpjLR/Na99knUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785805312; c=relaxed/simple;
	bh=YlIqWMwq0YSMmlCvi2HDRsphxY0rHpZzHJZ2VnLmYUU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lGaDEwRobiZRHefL2hZ32gL0hb9cpnXk/Bo/cdhRfDAtUKlFCeN6+2/Cbu5uHiEyBHewPmh8WnOOFVmU5zb8UvkWhemQAdasCJ2BS0T6Iwys5eIklNo1wG3PEETHTGWU/vaNWc/rt3zVPJIwGudSOamBOOdhc13xOziwksSS9Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NpW1Fubg; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NpW1Fubg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785805310; x=1817341310;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YlIqWMwq0YSMmlCvi2HDRsphxY0rHpZzHJZ2VnLmYUU=;
  b=NpW1Fubg8SiJcP1n9SJOUjqXAKV4q240LSwgblCGcEQRsMbGvL4D6RCI
   oJaEtK6iI2TMW591YHTiILCOupL2ogl30Qv9uXSa/PLEzcI5DctOliWO/
   BxpI1ZZvx5aGF0T1N5pjRcLiCEFKT2LDRdI9OiDdgF6pOAKI5azIJL13H
   gQCHM3PzqqbscxBfPvOhwpCbJbW0fB4UhvpPcPwkm32FxmNtoGXK1AYGM
   nYA+6wMBX/BghJNK7NOIL9OALWb4KIyAXxDv3Y+8a2UAqq1zGRPp2gV9f
   WU4G9UrjoFO9zG11coC9lmEf9TxoGWu10WSZ3OMQzF6bQO4cT4bsf6r9d
   Q==;
X-CSE-ConnectionGUID: KZo2XYGhTtibvwysaLx5xg==
X-CSE-MsgGUID: d8hhi04RQ42gclmuuijWVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86203063"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86203063"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 18:01:49 -0700
X-CSE-ConnectionGUID: hVNuzV5iRvmK3DirmKie0w==
X-CSE-MsgGUID: SIaJ/hpbSciK4ReEA+2HqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="263346993"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 18:01:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 18:01:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 18:01:48 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 18:01:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4GLj0ezgPUWB9Thzfnky3loY6QhcwrGbCF0USs6gpd0OoRt3FXcceqjY1TNTXjmgtehzyGzp9sN/qxhRUcC6dse6sd/3F3hE9ufb06TSDj1oNO/nqrT6hGjYXsGCzgtuymmh9IsX6tHHaCLIfWp0oJPsp3z7YV/ThGL4Lfwk1SQTRVYa9Usfqjw1UBFYhrIbHsN/3De1gPRJ3jIzNkktgcWOjEh4ZJik14SvDtFz+KWqJL/cInTKRBgYt+5ab4h7HXKnuZHJ0nwc4d5HUEztlQi+JL7dG4yQC8kYD2nsPskPGcD5SfDNu2jQDeDYjhUp9msStu8xl+NkszH0puY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATemb6lhJ01rmYLi+FK4MylADc1d8jcrEZowHqu2724=;
 b=qLGqKpzsGG8PUlA1UhUvJLmU/brOfsIa3/X9iFEa09e/pxtqYf/DeivqZXYsMhkawzzWoXo4kGFrdswpZPkmFXkgiYgkWMZaOK8Y34fh1Kz4oCZqGfQcOTOk+4uOyIGyuQP/z8uY0dBmEYaZR6rD2KCGm5vgx7Je18FKKSnf19rwh2Mj7mm935Va0lVo6RgH0jkuPN/4GI3Y1B1/I5CIHCwjUKmhbEn/6TZn+WfuP7MsWfnIDXuTDXZoahTKWZYtifIbFdvrVPX1iMjCzIcyOOpuA+IfSMMOIQ5qnMSvKdioVSelyFCO18VFCdC594AE+UI/foJYCyDUC5ho3wF+sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by IA0PR11MB8400.namprd11.prod.outlook.com (2603:10b6:208:482::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 01:01:46 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%4]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 01:01:46 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Jiri Kosina <jikos@kernel.org>
CC: "bentiss@kernel.org" <bentiss@kernel.org>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] HID: Intel-thc-hid: Support complete I2C bus
 configuration
Thread-Topic: [PATCH 0/2] HID: Intel-thc-hid: Support complete I2C bus
 configuration
Thread-Index: AQHdHXRk2d3Abf7y1EmmFn2+R2TUDbaMsgiAgABsosA=
Date: Tue, 4 Aug 2026 01:01:46 +0000
Message-ID: <IA1PR11MB6098DBBB0DF142C902121DABF4D42@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260727030310.3850984-1-even.xu@intel.com>
 <r60q2282-q1s5-2nrs-qp71-s565qn220qrq@xreary.bet>
In-Reply-To: <r60q2282-q1s5-2nrs-qp71-s565qn220qrq@xreary.bet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|IA0PR11MB8400:EE_
x-ms-office365-filtering-correlation-id: d63ba408-5557-48d5-dc85-08def1c3f4f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|38070700021|6133799003|3023799007|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: f/t0+4HTHdP0V+XgkBlWTZhrlmeqcwE7YcM+H3Nq+xapZB71fXiNEzb4bkIksII6d+P7HkjDQbNRr/8UWsq40pAhTdHD+xeWFr1I4SIpvlosEJEy0XMHlQxUeIepSsWyd939rA7pkmWM6mojYZeurRtgpyszN2C+Cu50LZNexyl786ss74H1LW+CDYKM9iiNXB/oHUk6z+SlJ3s5l+AN0UHwaudtL7B/XCda9OrwVbvebfQgSzvpovyTHGvbs1L1j5yyZfftrgcMSp5aXiIU9v/+4vj67R5h3zPj8vz2Ovu7gKG25i1fpi2nS7dI+zKMshoGpTfUAJ9DC3dbCX3V2iI8DZRNOcJ2u5WxYxzPRmxUjfwA83wgAypl8vClfku9kAYIPjnoMlOjgUsASWoLMzvrqxILuyRSa/H3bXCUb5IVa6SHq+g8QRsd4KXNA5KOT60xaleJiyAd2lfEvkj3X7CTrQjNQRGvNa+o2yaLjVKjT+JHpMU57BWtA2ylePQJRhBQIR7fL/rHNzR/aH9PsGA9/bAUs5lrI3/WK5+9VvGrZNEiYhjgJSJru7//2bWZ0rjaW/YEyOuDE4HlaHeXJTFfHPv2HH9ime0QVbRKQOU1PqSv3HujOB587adUcVDiK60/tICjDrknWMRy7IkLsqrFWopU+SaPYmYyIRoODiq92cdud1x/s1QmRmKGqqkrjv2mYYcafT1ILr83I40JBYhQmkh6ZA/D5cZTNLyAe94=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(6133799003)(3023799007)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KAiWkY4kR8scLoc2oWvTbxC8TdJwqfehucYXBZlnKHmx6JRlLFlFz9zwz58k?=
 =?us-ascii?Q?VyzC7STd7+KW95gAPBMNsxtfCvJY2RS/sbxggn+FIOWM9bjt09N4R9HQj6fK?=
 =?us-ascii?Q?Q9VgE6ymelVONvRKbSi+UiAbCQPsaXtDe/ToW2OdvO2lsEpywRROR82c4qGT?=
 =?us-ascii?Q?q2JVdXBEhPIVzBVdyyIH0Z+UJwvKyAX/VYAmUz47Z+HL5NJVponSA+b22fSa?=
 =?us-ascii?Q?qNc82Qt+0Yb+/Rcva4rI1e805BhKzvoAhz8ma4g6mcpV/UYfUdAhjlFAbPkk?=
 =?us-ascii?Q?0n97JQAPgskpaYCjmkr4CcGAtmNakKwIV37hBV7mLMTN5MIhk6MLEiK05NCI?=
 =?us-ascii?Q?bmlhn7bYAxxP7BlNuXtoGTyDRBaKRqC3JvoLiyWznYBm6z8eDkiR0Cvi6HJE?=
 =?us-ascii?Q?bdoW+3qqPM+96cqxYB53NCTZGg22idYFitYRNBOe9JFtpNAozk3YX0M1bWj4?=
 =?us-ascii?Q?Suiquz4o+c9QPK0uPgJRV7WgA8zLo9hnCLdAuIBHaYNjUiUHpCEShjnCiJIe?=
 =?us-ascii?Q?+JM4gZgLl6nLoKx86OUPwGFrezwnDQg1Aap1zk8mtWHTevRcX0PDf3qcBVDo?=
 =?us-ascii?Q?p3AI0F/df19Bx+H3JmfDdAHWCh8YY9wUXP10kdxEtZNRqYsDZeUynNDM7UzV?=
 =?us-ascii?Q?hPy+V4Sl5VHRugBiIlWk8cf6ZrD9J+FpqNlYYz1obqwR9OdKwladTv9k5xKB?=
 =?us-ascii?Q?e2QXKbHCYm7hqYvdaMv2pWA/fYJnXnjlPUly3wecNUHLAbfbN42US1uK2/AN?=
 =?us-ascii?Q?nP2kFdq8YYDAwGTNS2+Z6orR87KuVNqQjH+5DkPYzepBZK19Y7ptnC/3XkC2?=
 =?us-ascii?Q?lqMsr12Csvyn8kECGhHokNE8S0+8ifEGscpuDhI+oESN3GIULDzKup0iFxzU?=
 =?us-ascii?Q?4o6ye4vrxoJn4dDjL1NyEjPk/ZZmUFLWt/pXMI4nq6vAyPdx7dxYI55OgQeK?=
 =?us-ascii?Q?jYYPXmhfIufhfTW/lyKWj1bUMnusLcbQ3/k8gGWh+b7QquAErOH5tFkVAgow?=
 =?us-ascii?Q?6CS7cQiz7/1fy+RCylm/mxQuca74KpOwa084UX8rB5db2aVsgCm1gOc13wAz?=
 =?us-ascii?Q?77Z/VpSJH9PE1VhRHjKLrjVoNyLKSfQd0ZoY7dgtrgOcPaGc5jEawSCCC0JW?=
 =?us-ascii?Q?+hW/fLkzxKzQFWtldhKZen/4DGAfGV9470F1cNnv/9VfqCJnDjGIYd4oQ3YT?=
 =?us-ascii?Q?nkQnsnJ5nbZZzuA+Kef0CMA1VeWJIDu33XdHEF8sLZ8fBa7awJTupLpustJO?=
 =?us-ascii?Q?Dmys8KGzRta2OiKOO1HtELIknteLuSYJY1m8+uhqtx05dRYdTAkbeCYoFxXx?=
 =?us-ascii?Q?szSUpgRszlPD99Xv5N9ILmjxkXgpybSYNu7aBei7nEPKUvAj9nG0NDElRvgq?=
 =?us-ascii?Q?FgeV9V+nPWCI9GCsFS/qw8YFR69aB4orKmVCCOMfF8dsxNY/tURPdmpkhSAn?=
 =?us-ascii?Q?/WO0u6ywsiAnBqkpipI/PgI7ev5oRXBrra/29ZMLAQaIuNM8ljAvKZSG1J26?=
 =?us-ascii?Q?Zzl4ApEjKvNd1V5gsQdIEbf1sI2RrvIAK3vH8j8OHCqV8rp3RY+DJzmqTHTR?=
 =?us-ascii?Q?PiMxQFzBvweYpLS9R6JYWH6M7W2LLRdQics7xj69IHm6JW3HVUIHV+azQUGt?=
 =?us-ascii?Q?UV/b+mnxFYzfTJvClFZTOIQVtZHlrl4dvrW1ABCoEHWDTYbSHUnO5ACH8Xo3?=
 =?us-ascii?Q?hg8tmZk1oS/e3O4sfscSH7QgxwPBDMxGmiMa2M7wJwLt7ajX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eeJrXxj+d2rF6rqQTIMsRAzsbJxGK2KAhIVINtowFO5VNdWkS013SDhSyMFWr3VcmclohpBwqsxnLI273lcDbV+cjFHnlDiuJG2wMkwL6BvCaqwKKb3USoSIa7WvOlqW4gfNAzPcccGrr3PnoscUPSfwc6IsfWnyY5thZIi4Nv1iY/Vr5oqfjaPAcNTjkqpJg4cO4Q5aWUtrFVHApFD8rDPAYHEIGxf7FKLwOpge0OhNbWZnjfT/Gb0VoKz26FaPSuKufAhKF9Bd8800688K5eKxkpluBLS+nCS0f2zKQfqr2BWin5233/lkL6FTCy3yol70MvQOufGE1ws5Q+4l2Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d63ba408-5557-48d5-dc85-08def1c3f4f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 01:01:46.3196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RpnRt7/OqTWvcOuH90N9t9urEJ6VFuLM1GF9fqftmu8MXtw2hDzu+KXqHP1g0ITNXHcLZssYitR1j3l8IF57YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8400
X-OriginatorOrg: intel.com

Thanks Jiri!

Best Regards,
Even Xu

> -----Original Message-----
> From: Jiri Kosina <jikos@kernel.org>
> Sent: Tuesday, August 4, 2026 2:33 AM
> To: Xu, Even <even.xu@intel.com>
> Cc: bentiss@kernel.org; srinivas.pandruvada@linux.intel.com; linux-
> input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 0/2] HID: Intel-thc-hid: Support complete I2C bus
> configuration
>=20
> On Mon, 27 Jul 2026, Even Xu wrote:
>=20
> > The Intel THC QuickI2C driver currently configures only the target
> > address, bus speed, and SCL high and low periods. Additional timing
> > parameters supplied by firmware are not applied to the I2C sub-IP.
> >
> > Introduce a common I2C configuration structure in the THC core and use
> > it to configure the target address, addressing mode, bus speed, SCL
> > timings, and SDA transmit and receive hold periods. Populate this
> > structure from the QuickI2C ACPI resources so that platform-specific
> > timings are restored during both initialization and resume.
> >
> > Even Xu (2):
> >   HID: Intel-thc-hid: Intel-thc: Refactor I2C bus configuration with
> >     unified config structure
> >   HID: Intel-thc-hid: Intel-quicki2c: Support full I2C BUS config
> >     parameters
> >
> >  .../intel-quicki2c/pci-quicki2c.c             | 46 +++++++------
> >  .../intel-quicki2c/quicki2c-dev.h             | 14 ++--
> >  .../intel-thc-hid/intel-thc/intel-thc-dev.c   | 69 ++++++++++++-------
> >  .../intel-thc-hid/intel-thc/intel-thc-dev.h   | 23 ++++++-
> >  .../intel-thc-hid/intel-thc/intel-thc-hw.h    |  3 +
> >  5 files changed, 97 insertions(+), 58 deletions(-)
>=20
> Applied, thanks.
>=20
> --
> Jiri Kosina
> SUSE Labs

