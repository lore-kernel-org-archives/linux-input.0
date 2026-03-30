Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422AC18871F;
	Mon, 30 Mar 2026 00:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774831326; cv=fail; b=kavwQZ/visB2aIwcQ/Z7qy0y2+aerNkdKjCNEaSYXtphMXBQBdhcrgmmMOiDNsI2k9jYyoRCpO+dgq6mwbKaQ4XkwWOAUY50ijBNyLnELpRIUNm7Dzr4sxPes8o/DZXrmNYKkENHR+SQIcSgK5dmEVbKI9ZB5r87xUrtPr6d+Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774831326; c=relaxed/simple;
	bh=HVWs2iBxVW7ANrOXzHvTl3jAKpjtMQIT3EjNNpCOMQs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nb6wicGjOy7CcFQG7cB3wIrSn90yaBBCHeFqDzqqgtu+f8AVmE2+lhblT1t3bZKFkJSrx9AN64PaO8vA1xhEkVfm+okJVm3862/T09L6bLyMRwViqr5zry+tFIlm16zvY0xMVBFPd1Gt8TIgkMcHHaDFP2efx9Eok+2MRsEO9fI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XAjaKszI; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XAjaKszI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774831324; x=1806367324;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HVWs2iBxVW7ANrOXzHvTl3jAKpjtMQIT3EjNNpCOMQs=;
  b=XAjaKszICNVoAsxh3LoqchWBe3WXsK54S7LE/uQRR0Qx/v+PFyqD1yK5
   XTznd8vUcAiUY4/mvXj+mLS2srfsw/H0F08hPx7Wl0y1arOVWkfmnNAYN
   vxtkFgV9djI8Dz/SCrQVLp15CRHTBtzY3uVSF6CtjrOvWE3xvGnmkDP0w
   hVLV3h7D3S/5gnlSzjMrTr7uoWizncL4TMoBGeryyOi16NgHWCOgXwDCJ
   Hp7+NNdiD283V82QqLZRxeNqcpRLXeDVA0SgeeFmiQKr84ykkm/N58NZZ
   eobgdeYoZAWwUj0OChRKoFq0y/5wBI2+WrACEkJVwrWFqY/DznlmCfRW5
   Q==;
X-CSE-ConnectionGUID: KghMxChkTSKPG1tWYTUyoA==
X-CSE-MsgGUID: jucCsqQ8RfCrT6Lsh5hmkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="63370350"
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="63370350"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 17:42:04 -0700
X-CSE-ConnectionGUID: ucfvLR8pRyKf3sODcCHD8g==
X-CSE-MsgGUID: UhqxqZW+RIK/qkzQBuHFeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="230365940"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 17:42:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 17:42:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 17:42:02 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 17:42:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8E0jnonG+5sNl0XzgX7DuB3EPC0GVb16J0uVAmuShraDrN2f0FOvUGHu16jPIo/oN5/VxzpzRwF2nZ3+NRNSrYa8Gjy1rPxAxAI0zX/Y0sgbgRMyeDZ40gHfLWZpB7z402Sv2on8ULXaJf2knIJcw8qfWcWivU4u0bNTghnbiXAw9uy/i5bfRVE1j0kKEFG8z9eJH6zr5s9nz3nKd+KjPbzL531bo8iaxEDprfdNUJT4+O/WzfuNmihNvA7m+UXKSho6W0Y7srlusLzHIdXkeRw5x6w52zaSciF7HWsGYheS34aJ8eWIFCsFAvage/mRuVjj1rEy6UowI6jJCpMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVWs2iBxVW7ANrOXzHvTl3jAKpjtMQIT3EjNNpCOMQs=;
 b=RNH6I2LtjF7+cm5fRvih3+wPFN+e8uLtWQKC5kC3BKZ+LlJta1I38YPY7qg+upyNn1wVe29NscVmMnKcFR83OyRfkBwhiH684oCzzW36hDcoDAbpaqlUFeQKxgLCXDy3na5BHhPZrkyVo2PA/CH7uFokFEBUlgIYpr7DMKNO/PNN8AdjJ+MnnFr5c+rV2p9oIS++/HcPoHDie5wv04t7SQsgeCZzahm3zdfI5rqslZNF1M9cMUU7pmBBu4TglJLWbnT1uv2pjhjyXMoHyQwXYqc1paGiaSf1eSdVnxHre+NYdfPbEvpp8q6Xv/xjn6WeCJo5t0BBdVNs2yEBgppzqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by IA1PR11MB8785.namprd11.prod.outlook.com (2603:10b6:208:599::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 00:42:00 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%3]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 00:41:59 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Jiri Kosina <jikos@kernel.org>
CC: "bentiss@kernel.org" <bentiss@kernel.org>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui1"
	<rui1.zhang@intel.com>
Subject: RE: [PATCH] Hid: Intel-thc-hid: Intel-thc: Add more frequency support
 for SPI
Thread-Topic: [PATCH] Hid: Intel-thc-hid: Intel-thc: Add more frequency
 support for SPI
Thread-Index: AQHctoYiOyu2aQKwAUqMv8p5jtmvALXCXmaAgAPwZnA=
Date: Mon, 30 Mar 2026 00:41:59 +0000
Message-ID: <IA1PR11MB6098E1719F7D2848FE13A156F452A@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260318032204.835621-1-even.xu@intel.com>
 <3op0o0rq-o5r3-4n68-n3pp-237s14106qs5@xreary.bet>
In-Reply-To: <3op0o0rq-o5r3-4n68-n3pp-237s14106qs5@xreary.bet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|IA1PR11MB8785:EE_
x-ms-office365-filtering-correlation-id: a486dcc0-f9cc-417c-7349-08de8df52740
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: aPI4q4PLODC0fi98LsqrWaqLyx+V5II9oQOXUmJYj0SlS2Dc2gzHglp1mCVYDeUjr67Z80fIU1fPzWrDsyWouC1qTfd7ngJxwWfuCaG6BHZkwE14a6h3wZKpxiGl7wsWDmvcnTUM57c0Q8CU2PZ7tFGdhgTsA6z93DLc0f9zAF/JOTYkigJP47ZaUA8ol7f4IgTe4HvXZm6tQ75xduUo0yQNZfa5/eUNX2EqAMVUTh3S0ggnrmAcU3BH5+YSBWXEsEFuGbXo83y6MSLzzceutugOWRcLwYvgfyWoxgYkY/ZAzrt+TZ84Wgn9oeoQhNBb5yGTIKLppjwt6rh8Dvg1sdTY25LR5TLgAkHLPyJyv1G8X+RQG82KGYTn/sJAxZIEeuPidEBsoHxD/M7BpZWuXvSjdQNzDIaskMQgW6d9LAUAXBtiddB6lDs4Wvv9/9T7gPhRJrML/XfNorB8CcBCumSbsuS1FZnK6GgjFwnkBarkq1m4OgjdUp01Jn0qkwAAGjIMs+MCPWl2n8Gbb5tE85JWI6hqEJLwKoZgQvHXBJxdEcaR8pt9qiaFbNVaW3hSsatpslEPWwFBbJqJIJ4BXq68OEiSoUPIaEGUHHq+E0UCoh/94rWPo9TEW1I0w145loi1U1IMwzUOtKJFaBPXToCq8ZM7jnu1qXlpmN5QMCeucYh5zKuSGAJp10DIgzw8X25zFVr457oWjeizr/SDHXJwwujCmYxdd6pf+FbTKwDbEMB9bNfdSYGZf2Jjtr3Syxnf0lyuzmoMEMIoMKkmie/0wANidD3VtfV+L3e9vaw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q6eYSv7XZfeQSrKOwr1gKf21c/S68KPUTOJoa3hSbxSpDW7rY7F1G1gsSjEh?=
 =?us-ascii?Q?KFh+beGLLEhSvu87f2Z6Hwx2kyJFJH10h9yPkx+GX3C91ao6lW15VfF+R98O?=
 =?us-ascii?Q?XTt1JvMIzd4HQ6OQ8l90BajFq7XosLV9L7NG0UmG+wvltwJUn6bhzVHOcCg5?=
 =?us-ascii?Q?Eeh2NdMlvs4vjjQIBKisUIhXVeX4nUVuEiHUMnxySXg2w8SuAWrmwlJ+LUMj?=
 =?us-ascii?Q?vX30EfF7gPafykmwe3jE0D/t9v/ix0dLySFtKCCyAcTgaCaTCoXyYWQnCKa8?=
 =?us-ascii?Q?ZzslnKPkitruKQUWyoAJv2qfsM3bO7YpmggOW0mbfjq6Q5JVD5KUq3uFMHn7?=
 =?us-ascii?Q?hTmjikj0zBbW1F71DPQUlOizW8sC0aJ+1DJOJR3Z/MCCrEkK90C+knre94lg?=
 =?us-ascii?Q?3iRYh8OxIGvHmczzGdlPtsHeGTamMl4iR4lvjq8xkS8itzZBS5ygyNE8ZygH?=
 =?us-ascii?Q?gkFK9LlKhsC5E+L6D+2XlBVU16OrKf2OqFiWqIrFRjYZa5qUaa4YPAJZaD4G?=
 =?us-ascii?Q?mo3IeoH0HQybTtHCpPFQeF0NtBdBUKwEwKL4yHtvy0z3hQP4jn/FcK8P5ffS?=
 =?us-ascii?Q?siLZu75nhmKIWwEmMWgmvi0h9q+4e1NnVMPhYS9mGeRHUn6WxuLZu9E0Bx7X?=
 =?us-ascii?Q?k3AEtd1QennlMq8hkswcFO+clkTxBW95ugFW93hsKoTO8o9RhP4KNE6z6+QT?=
 =?us-ascii?Q?oS3ulqdL61cxUckBcwtjAxgYkI/DSZy41TrYUO2VEiWMDjAIZeZ/5sF1iJNm?=
 =?us-ascii?Q?DxUN90AWVNDsD7kaFEogUQ4MOE1VrSixIrTTjUhPHQrm37hQUH7oXH3Psjg5?=
 =?us-ascii?Q?GdS45o5JNgheqpVbDpzex51ztvYNDF4PJx8A/NY2n3ZptvtBCuFlNukM10Tx?=
 =?us-ascii?Q?763oEQ4OyBGg4Uv4fI2DIbjPrshKZlE8VOG9vdfmkO9lGEjBBxaevQDD0LFo?=
 =?us-ascii?Q?dIQXnoQ115jCa1gMuTzcBCt6a+cGtDg11gX0GMjTooSRNlg2EXjkCZQO5E0W?=
 =?us-ascii?Q?1nMUNU1NnsX0CV78R2eKFQKf7/FnXjKP0M5XVKSVm4nufxH7xL0sE4P0CdIg?=
 =?us-ascii?Q?54MOrCyBfJRGQ9QXI/SG459iB8aJrZE5ETQF0jhaOWdWopoGEQbf+VV1jVBr?=
 =?us-ascii?Q?goqE4hqYaO0B1gbxWG0LEoG2FL6yCdMIWRCktJ0MDmEPP0E+G/V5qPmg5lFp?=
 =?us-ascii?Q?wltrVCNwkFUyHmu0IUGSgr1WBywI4bSX1sLAC6x3qgIOuNaSo1AHPvZaEAJz?=
 =?us-ascii?Q?tuRJyiMQlpNgJBciPMrKMrCRqwspve1y05YzK22Un5+pwZsHbaglG+vrpW/m?=
 =?us-ascii?Q?8JsK6N33vxpGC1rfFdD5nq4U7NG5sxvx3TkAB5SyGvBu0I2OmYSYB610/ICG?=
 =?us-ascii?Q?Jzhk4qCjy1kFv34vAxZaez8qEOjuhXMM6Bxe6x5g1tZiltjhViHcPdSr8gHX?=
 =?us-ascii?Q?RuZW5SRs4GL5hVjspMvfhlDt6zMAolh+MfyAgrv+jRgGpu+9/hJVIG3ayImp?=
 =?us-ascii?Q?/kpbZg5G00VeUcR4OIrIKeYj5QmSSqUP85bCYRjGtdquQrOS/iP0bMNM3SPc?=
 =?us-ascii?Q?JbYjW8Z1bGa8gi/N8a/AVfyj0qjM8hzSyncH+Sr2pGCDDvAlkKcgRSGXwKOJ?=
 =?us-ascii?Q?+24xdv1YvHDaSjDB8+4v+Muu2ZFWCi7AG+xd38kCJTKYVp9GcE/hcO+PeWvf?=
 =?us-ascii?Q?MUB5SULAjgB2wTMEPsohffOYJUEuEXBdvcXeSXSprfsKRYpZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BmshZWy48sFYjeD9m/98P8wcxfBWLHsM8puFb+MYoq/Lw5fyb3Kd4ty6w4UZ57xB8lZWgRvfleVaTas8KGrX7eQtUt8DUtFN8v0t4jlf37elJpwC4jhmMaTVfUuxVE0uYasOdAzIBUjCj59xSHc3JDw5goj/YiHUy34zi2BZsE6np2ZvCfovhNIy0lPBFDsny3ytw9J+CZ7s2nnnRfN2S9U9ntGw/xgXivQhyyrhJpgYejkdLBtWJpg8CsrqtFVTRZjfd3Y411xIBDoGxNPB3VOaC8hA5EQrN63Y7txbx9GGDSVciHDfQ7iobBsPM/Mg7pbMbVI8uHl9JgVdVPbW0g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a486dcc0-f9cc-417c-7349-08de8df52740
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 00:41:59.7637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yStsSom/UMeDdbGDCbCJv/psj5RD4xRFSOMHpkDOyo/BJchUcNqbW2uT5oTPNF1+2MURZbg4KIBhP93ynGI5Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8785
X-OriginatorOrg: intel.com

Thanks Jiri!

Will use "HID" next time, thank for the reminder!

Best Regards,
Even Xu

> -----Original Message-----
> From: Jiri Kosina <jikos@kernel.org>
> Sent: Friday, March 27, 2026 8:32 PM
> To: Xu, Even <even.xu@intel.com>
> Cc: bentiss@kernel.org; srinivas.pandruvada@linux.intel.com; linux-
> input@vger.kernel.org; linux-kernel@vger.kernel.org; Zhang, Rui1
> <rui1.zhang@intel.com>
> Subject: Re: [PATCH] Hid: Intel-thc-hid: Intel-thc: Add more frequency su=
pport for
> SPI
>=20
> On Wed, 18 Mar 2026, Even Xu wrote:
>=20
> > The Nova Lake platform enhances THC with half divider capability for
> > clock division, allowing more granular frequency control for the THC
> > SPI port.
> >
> > Supported frequencies include 50MHz (125MHz/2.5), 35MHz (125MHz/3.5),
> > and 10MHz (125MHz/8/1.5).
> >
> > Signed-off-by: Even Xu <even.xu@intel.com>
> > Tested-by: Rui Zhang <rui1.zhang@intel.com>
>=20
> Applied to hid.git#for-7.1/intel-thc. Once again -- if you could follow t=
he standard
> shortlog convention with all-uppercase "HID: " prefix in the shortlog, it=
'd be
> appreciated.
>=20
> --
> Jiri Kosina
> SUSE Labs

