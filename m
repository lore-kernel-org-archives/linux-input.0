Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225F6175A80;
	Fri, 24 Apr 2026 00:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776992016; cv=fail; b=himP/k2U7I7euVW/DlWmWSuJ9HcKHI1zoahRjBL6W65Txj5zlNlMAOxwhHPUbyw34+lCjpPydg0QKnCVikxNmnF6uXrcBb7p2sg2B3KNTXH1HQsqRZTD4vvXxKwtoLKz2BdIS0JBR7kDXVlHzb1q+Y/tgTmVxEP4ADJzBp35css=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776992016; c=relaxed/simple;
	bh=QSy/jyt3lWrlWUr4KNKzsAgmOcPrGoMS6FEzwHjVFGg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gJPrMzjCdoUjOOmP/6B2/oSQcmcKU0fp8fJEo5mdccqwg1xQ9nTJFEpwDnFQ+e6ZzC+HOS6RM/ld5FdiVRul6zkS/xBMTuqRkBXUqCyFBeojSSu/+uDPX1t2xo+hmDBSXlHxNboLLb8LXl/fDbIWYWYnKqHZLIQAytXOvwJeOcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mg64Yg42; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mg64Yg42"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776992015; x=1808528015;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QSy/jyt3lWrlWUr4KNKzsAgmOcPrGoMS6FEzwHjVFGg=;
  b=Mg64Yg42zrZsaWja3BJMWCuRnCQzoR7LYFJ7XPpL3LZ/IBdGrqvtOaGr
   EiigIgmsFzTaPWq1V6/KBpCfm5DD72pdQsFAm32yPbiYcqUKQykzLXfXT
   9i3fGodNvJK0pr5qu3En/gOkyuSb8m++4/TRzlDqQp1T6fsSm3qfWm1MC
   z3xkm8crDJRc5zGTPLc/Tv6oC85Ae0jhOEH9Pv1WbjJOoVRaikZxCzMpe
   E2O3KMFa+EC0DvWiTBeXXpiEShwTRJtkku0JSK7WetI0W7vimqTOLm/6r
   ESkRiPpj1H28WqRs76X/pqHS6aupNiPTQGvvUbF98M56cRnxMlAyq6Uw5
   Q==;
X-CSE-ConnectionGUID: zT9B0hRBS+GfvNbr1glL0Q==
X-CSE-MsgGUID: ovDPHSoeQ+WL7BcjBEjMZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="81577181"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="81577181"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 17:53:34 -0700
X-CSE-ConnectionGUID: Td8SlU5iRYG3xqOSz9qlZg==
X-CSE-MsgGUID: wBagnA5TSqag1PhpVdZ4Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="237867614"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 17:53:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 17:53:33 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 17:53:33 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.10)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 17:53:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCSP1E/QCKpat4oQNytFIKuP/rTHSNKaghZpkc3igwpPUxlfbG3ccQoc8UcE1e9vp7dMZ05ijz1SYhcjLYLKzjLzTj77RScd9KXZiSVkocJ50jANt3A989CoxED+4+M3V8Z4rAONw7iA/E6i8eChnXkr4XQnIRJpazX2pyy3jj8Qz+i6y2Qa7CVWh8kvMle7O/yn2v1DhRk5yGrAnkow5H5J6oFemeSbDM1d+8AUIIDFxl+lIPuQOdHwQOBMLwEgOn6qYIyjzqejWdUzb3EZs6C4G4x84GtzPK/uLaIkrxuVBTryUctbQFxMa79d8USIkpC61/Cqmvur2K0dgwRZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCNu975Rw6+16gGswtT/xE2S52s2rFY/+hX7opqDLzY=;
 b=OxjTG9NSZwj6PQRUJ+WsAtCa6xpTmyN3uiqTI/Kb2j5nHWN+jyPwoBjydJtaSEV6JSU09K7i1BPA52NMVhKdYxvdvvV3QaIatAPr0x+r1SBBYAlgnGlxrEXfvepoSyR5FOU5Dxcxmcj8H8NHcZF/c6CIIbd1wHcNRNviEq1+lI949ZCwEppowJbYb2ZXWmftrWljd4ex9wjE5ZOnYCGwLki4XxqMvqckL1wR0vdgElsfM72wzHIfy4zei6K/KQim2wl3ZOsmJSe5SVRTyF0kHfLwsDBQSDiD60Q0mYjKV7Ie/hDLv4fn9yhoKjv/Etp3WJbKXcA5lh6gP5U0N6Q9+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by MW4PR11MB8265.namprd11.prod.outlook.com (2603:10b6:303:1e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Fri, 24 Apr
 2026 00:53:28 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 00:53:27 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Dan Carpenter <error27@gmail.com>
CC: "Sun, Xinpeng" <xinpeng.sun@intel.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>, Mark Pearson
	<mpearson-lenovo@squebb.ca>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] HID: intel-thc-hid: Intel-quickspi: Fix some error codes
Thread-Topic: [PATCH] HID: intel-thc-hid: Intel-quickspi: Fix some error codes
Thread-Index: AQHc0vBF3/ql+/xhpUe6X3uxXj+6ZrXtYw5A
Date: Fri, 24 Apr 2026 00:53:27 +0000
Message-ID: <IA1PR11MB6098E3A5787DBB588126C84CF42B2@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <aenFyk36rTnrD9s3@stanley.mountain>
In-Reply-To: <aenFyk36rTnrD9s3@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|MW4PR11MB8265:EE_
x-ms-office365-filtering-correlation-id: 942c655f-af13-407e-f44e-08dea19be5a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: DKAJ6lmPI4j36SRSkGiNX/A2Dk3GvKF9SUu1/zZg8vtQllBDcBLKGG7/zgVb3/2LxUTsqTgveZIAgb/mPdpSg+JLz5OSriZUxrgtA+J/Gja0xe2eeE5FYtJOMqnFB8BpEbDJptQY9B4m2pM//RIjh1nDY7eguxE82pgoyaNZDVsk2pVnIACpXHnXjrcy/5BPFTf4fyozI3fVWr8jm1Xs8/acvpIIvItmhOMZ9NDmJafCLcTNkVlT0jQ7xtCniZNeN58CXbKaW5Clk09DMGjeXjXHkBzQ+QncGUKcA83/YA/HGV1a13o8ZyHJBBOJR6eHh9GYGJxfNlOiM5EVwZFI4BQyZ0D+L+BOB7KALDTpuX25FkvUMa/Vv7QhbCnvczB+yzwNpPRds5mqy+E3subPQBOzcXREbR74HL1+Kl2bNNjxnSUijQ/dab7WE8NJUCPN5S5Xn3TGsqBShRGeN3Ciovlk4LHudRpcxtx/+6kbnqbRQoOea+o2isrgE4T7InNZhWaqtEErNKKVnTqmDKMuC6tAD0gSfSAUISjmOA9iU4kyyHX1jBrACLsIrUvNw/BGWjE2meUx4g1jroLb92jzSGyoGfjmGYtv04T/rZM6DE2tF/3MXRncB/KIpLBW12xLTWF9Roc2XkOGyxcOHL/pRb3bfuf14hhze15bGWRgAbjkpBy9e3jypZhyYZBvzs1/WE+BR7XmYGJv5U2GM92Me249cMHRqAQxdHO6breMmDHPFzJceNWd7rCZ+o7avtJgL+rXJQFuzzYtBcxcS5hNLltwEobXYppbcVbw5/kqrcs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1M1u/1t/xxYjdq5gUfWO7S0mSY6duOxTwQcH8GMJ7gdxca7F0Y1N+gHnjQHC?=
 =?us-ascii?Q?r38LbbYj1isQ13d3w8c2PrtktAsCpOGSL+lKe5P213gUNbpta0KxrEy4+t/l?=
 =?us-ascii?Q?xyeTU9qJVlA0lgbyvrFGb78O7AdAxL095SMhMBdnVCVzQ97PN8rfhz+FUlG3?=
 =?us-ascii?Q?bCUve1fPE7a4i6ca67GUjQAyAPTwCTLeOuwdYgGrrUYrejePbRAsWd+sw3qp?=
 =?us-ascii?Q?eFEd67ORfX+wmo5Gd9KG+Xz/nPxPCY6fRT6T/2W/5NwF9APjFmjIaC0PQ0ZV?=
 =?us-ascii?Q?rkmZYenWICx6sGEMJtnXR+j0A/W4AIzJWm1K//2K1jFCFDhhjoELWzdy/giQ?=
 =?us-ascii?Q?LXW9Mn2QgS6uvK61vl/Dnsr6cclwHxDrJCVKIAYsQSA3+vSS8P11SnUOA7WH?=
 =?us-ascii?Q?UKKUAJQa5rcg6aa/VT67vlWmhUg1tWsTJA/lvpCET4UpHbS1ETI6L3330EBN?=
 =?us-ascii?Q?jHbXmfuFHAQIl/9cHdfR0JRQ0Z44PnXP1qV79lrEgQQ6yYaZB2QRdUhEgGmO?=
 =?us-ascii?Q?8hHwbpnNyhbGp5QZZrQDFIqgkPB0eFw7R3JmgH3xsofcov/svJERqXffkuCx?=
 =?us-ascii?Q?5vN6IcmmZRrEdySp78lSrRCVG59VlmYYIDrW+AWDSDcwj3FJk5J9ojjDv5ns?=
 =?us-ascii?Q?pshVdZKA5xE9w4Qt8GfXHvou2vbh8YPQP6fGfznpHzpTuuFWo6MZ4yUbDYCS?=
 =?us-ascii?Q?lw1y/QzOhiHRcNTTJrahnn0HNPscpsl9zoDZWqlYn+k/N5B1kM75COQruu5q?=
 =?us-ascii?Q?8l6KK2igoJg2Zkcz7OnFOwhkCvnJ+jQEh1ZVxrlGUQc7VQ+7MlaQ8j1AscwG?=
 =?us-ascii?Q?kWCHiPNI7yTr4dkMqTFr78YRLapej9FYWej4atrllNRt6i91mPaAcSW1VZSS?=
 =?us-ascii?Q?mi82xzoLIW1PIB8N32ulgsHiCFVVXMzD0tkaBtT96DsNEM9OaTDKi3ywjS2q?=
 =?us-ascii?Q?TbilNOU+kJ46WkZZcCP8pN+KpilYXBW3FLiu+hFnsNILQ/hFY6fTgmcyYbAL?=
 =?us-ascii?Q?5FFUJI5YAlBuK2BWg1cxAzR0Bh3jepa7fOx1J6h66xaMwKA1WiAfTWzT0SHA?=
 =?us-ascii?Q?bPLev6FOjZyV1SgV25fNdMhxm2+tLUI/G+pMHs1VUwPNnVOJSEIeG/x7w081?=
 =?us-ascii?Q?xmJg2HNxa+1i4XnUQMqb3GiEWAOh3kMoaOkhAt2oPjKZU+anvtv/mf6b29Ic?=
 =?us-ascii?Q?u/3fso7o5QnLSecaR92yD6qCrZXcM5M+O2W40n0iEg381tFuXQ9xAwn7IUQu?=
 =?us-ascii?Q?/KdfFdCuln/ZlrIX8sm+XD873evtHu25y6RmRBWKR0GcSpOqcsYF8e9r9ySF?=
 =?us-ascii?Q?CMocBtr5bIKI6xsCRP7XGaJroZZK+NRKbtvPbE0iPoH5V4a1rN8j0XzFOFej?=
 =?us-ascii?Q?KMAPSO6A/6q3J8T9Ji05sGZ3daFohAYfxziKdMMvy+u07nZ2JHtDkghwq/wx?=
 =?us-ascii?Q?TjNpBQl2XQkR6CUYwJDgF25BMo4+v2fhVOZjHzMPgHUK4XfuUU9+uyUPeKWi?=
 =?us-ascii?Q?BEHcl54pJ495zdY8FlIdOBLqM0YFxJaCtndD2K0O0904AqaRI6JIzhxXSsBy?=
 =?us-ascii?Q?kv2MrrZz2igw2Q9jivaSLsaRVweH+KkUi799dWiS7Ee8qCh2oeR1uMZFNhpw?=
 =?us-ascii?Q?q0RNYZyP3GbUldud+BLTVGlQnMVw1h/xk2TCWUU+K7OxfvMOEeHBBMNBlr//?=
 =?us-ascii?Q?Mitswdj9Hc2/5v3OCG2aMvOGRM1oLbe/i+NRcwCa57iP+Hpo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MhXROmGnkhieedz1QO0ItMunC8G/mJt2T3o/fekVfQ3640EXQWhh0EjsOgggMQWfAuGwwYnenPNM50XW6g2bqma+wsor0rsBvFVCstQOazksuUVyK0UyctgHC63TlMn0YwpNRi+2MbsFuYfUdML+cgDqNXKsnr3jS13vJd9r5oFQn9d1EIhoT+it6opl9TYHM7a5Vn4KmcMaGxOMcLOeKBG4z41CTSdNfdYc5lT/+y9+PQReHLbjV+8HYAJjHbzBncnhe7b6HxW9TAGmZT53WJ+WvRSI9n9Zn5OJm35ZGCarJTHXJS7E9EGjCSepQ/dKm2HjCcSoW/R0Fd0CGSjz6w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942c655f-af13-407e-f44e-08dea19be5a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 00:53:27.7109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5kJWg+Fr1esg0uxZLd0e19Du/7Ay+KyJenw0fL/9zdD9eSgZtGW9DhRYXk0S7YqDxYGavo4fPiFL26XT1P+83g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8265
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Dan Carpenter <error27@gmail.com>
> Sent: Thursday, April 23, 2026 3:10 PM
> To: Xu, Even <even.xu@intel.com>
> Cc: Sun, Xinpeng <xinpeng.sun@intel.com>; Jiri Kosina <jikos@kernel.org>;
> Benjamin Tissoires <bentiss@kernel.org>; Mark Pearson <mpearson-
> lenovo@squebb.ca>; Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>; linux-input@vger.kernel.org; linux=
-
> kernel@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: [PATCH] HID: intel-thc-hid: Intel-quickspi: Fix some error codes
>=20
> If we have a partial read that is supposed to be treated as failure but i=
n this code
> we forgot to set the error code.  Return -EINVAL.
>=20
> Fixes: 9d8d51735a3a ("HID: intel-thc-hid: intel-quickspi: Add HIDSPI prot=
ocol
> implementation")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> index 16f780bc879b..cb19057f1191 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> @@ -94,7 +94,7 @@ static int quickspi_get_device_descriptor(struct
> quickspi_device *qsdev)
>  		dev_err_once(qsdev->dev, "Read DEVICE_DESCRIPTOR failed,
> ret =3D %d\n", ret);
>  		dev_err_once(qsdev->dev, "DEVICE_DESCRIPTOR expected len
> =3D %u, actual read =3D %u\n",
>  			     input_len, read_len);
> -		return ret;
> +		return ret ?: -EINVAL;
>  	}

Good capture! If ret > 0, but read length !=3D expected length, the error a=
lso needs to be thrown.
Thanks for the patch!

Reviewed-by: Even Xu <even.xu@intel.com>

>=20
>  	input_rep_type =3D ((struct input_report_body_header *)read_buf)-
> >input_report_type; @@ -318,7 +318,7 @@ int reset_tic(struct quickspi_dev=
ice
> *qsdev)
>  		dev_err_once(qsdev->dev, "Read RESET_RESPONSE body failed,
> ret =3D %d\n", ret);
>  		dev_err_once(qsdev->dev, "RESET_RESPONSE body expected
> len =3D %u, actual =3D %u\n",
>  			     read_len, actual_read_len);
> -		return ret;
> +		return ret ?: -EINVAL;
>  	}
>=20
>  	input_rep_type =3D FIELD_GET(HIDSPI_IN_REP_BDY_HDR_REP_TYPE,
> reset_response);
> --
> 2.53.0

