Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEAB3358C6;
	Mon,  8 Jun 2026 02:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780886924; cv=fail; b=mbbjV0OgkL72WoBBVO/WaddaGZCx1lJH2eFtEVJWqL5W+5Q9To4LfDtJR/Z6xfkS792HU3FpZyYVrSiBd/T744KJQMyAhPnfKZafdVaHpGOYB0igSqWx+SAxCZdGIsNfKb0gICnU2TxTIIKVCOAiCcPsfY74B1ISZHswO3EydeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780886924; c=relaxed/simple;
	bh=ZzbLuTi3TBKD3mnElWY+Dgpp859HQKZRqpGclDo5BS4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RgT792siDyMyFw1DEkSrzBnY0UbmwVLI+9LWrPmlXk2SCEBZ1CMcmO8jjeinrnYyhFkACz/boRoN30Ai4p9iMvTrA9XREkmWPv4IRXjRoKtJMsvF+Tha1ipHUNtHUxZgh/eglecImQUjeYy0rFDJay3XcBkE+3lAiPueOi8BgcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTsq2Gnt; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTsq2Gnt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780886923; x=1812422923;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZzbLuTi3TBKD3mnElWY+Dgpp859HQKZRqpGclDo5BS4=;
  b=cTsq2Gnt6c1fBv37wucudpNxRANKWtPtYu5NFMmHvlc65ZNf0UAnx95T
   Yomtkmvhn8JawlC2SG86ZlsLJEUe0ZIBxsQ0KxBHcLCSOjOUGF8xgU5/X
   X9keEVkJ7K02SJnwAtLJiPYFa5RBhGWyc9MBWiDO6EuKtjNiYfDfj2ti4
   36mKcNhV3PV8bn7v1Jc8rFQUax3hk/T7BmWyPP3L651M6xXXMiownPCwT
   hUNnDAzXLLyYqaIGUAGPNOrU+zlZ7Z0mjn0AN9ROYZ2JPobgd1BssZkR2
   tN50SwUJLr8GXI+c+eI1wLG/A053+lCnDqzjVx6hKJD0mu7LoLC7ErDPE
   w==;
X-CSE-ConnectionGUID: 6Cg8xOCrQsyJmyfbu/6/GQ==
X-CSE-MsgGUID: 5JG/cphaT5GJHHkVpjsk8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81593135"
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="81593135"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 19:48:42 -0700
X-CSE-ConnectionGUID: cZd+l/AETBCnViKdWElO8Q==
X-CSE-MsgGUID: Ithyvi0GSfuoRuiIG+SAZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="239064398"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 19:48:42 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 7 Jun 2026 19:48:41 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 7 Jun 2026 19:48:41 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.45) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 7 Jun 2026 19:48:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikbAW7i/ubvYjpT7jLEO4qMhRQuTXcM8SKA3yaSkApuWN+orkW9cCu6lXdy43w6Zhrd8N/5eu3Ot0AOW3UpklLn9nhWdKF1tB2PJtyPPTJzscvPSuLBySoFs3tgpXGL7/Dauzni6V3idDnZYYUcAezk7S5dM3WzePLwl79VPkese/slY+q0VmW8eplVIpurDgZhCJcu/6j4L0Arcimlkic3Bu5IQDWBo8UG7qzZaX5GjOdjeNCs/jBxBbcxeRQ9oItK80NMDjIdSgjX82BRLqqnaSCTOD/AQc8beXHANF7c88k/+9ws7XUsDVMf6qeJ06ETYNzMxKIOBOKvpTKhBDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efsGiFBbp2Z1tAypTOnYVijSQurhMZT0NERrpNH9c0I=;
 b=fo/heU5h3q7ypACIgRXg2wy2L0RwjP0330VqZTQ0gNhSiGrxPKoxWo499Ngx7TNmn8Kpf+rwu3tk4T+4ITC0pKhiLnZ0z/9iTzgO67BlJitzBzAZVFCa82FRMAbxnx9SK4gTEUbo/KH0WW4iHJYe9Q7aM0W4ETOj9wUKorzMd8cTTBVbJBX1isiwe1Si1Ts18l4ieGiCrBLDi6I3LO3LFcyIo2+3mNefeqPLbEigtJ4WDhAxAxvuZwGzXscCfCpEz5n8Otbqxg2Xil6+dGJ7l8KBiq9TjFfV2NOrRKReektsRs83+D7r7JUiMUxxWousUPQ9+MJ2oZEmy2aCTlQ4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by PH8PR11MB6562.namprd11.prod.outlook.com (2603:10b6:510:1c1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 02:48:38 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 02:48:38 +0000
From: "Xu, Even" <even.xu@intel.com>
To: d3z <d3z.the.dev@gmail.com>, "jikos@kernel.org" <jikos@kernel.org>,
	"bentiss@kernel.org" <bentiss@kernel.org>
CC: "Sun, Xinpeng" <xinpeng.sun@intel.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sakari.ailus@linux.intel.com"
	<sakari.ailus@linux.intel.com>, "abhishektamboli9@gmail.com"
	<abhishektamboli9@gmail.com>
Subject: RE: [PATCH v2] HID: intel-thc-hid: intel-quickspi: reset touch IC on
 system resume
Thread-Topic: [PATCH v2] HID: intel-thc-hid: intel-quickspi: reset touch IC on
 system resume
Thread-Index: AQHc8gxGtEn4OJ5ccEidswczakTvzLYz/lRw
Date: Mon, 8 Jun 2026 02:48:38 +0000
Message-ID: <IA1PR11MB6098E927297E716FA72FDD04F41C2@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260529222210.1532876-1-d3z.the.dev@gmail.com>
 <20260601211828.112626-1-d3z.the.dev@gmail.com>
In-Reply-To: <20260601211828.112626-1-d3z.the.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|PH8PR11MB6562:EE_
x-ms-office365-filtering-correlation-id: edab8d3c-1a36-494d-be34-08dec508713a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099006|11063799006|4143699003|6133799003|3023799007|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: EAaFT0mgwpIzmlnHGTBJZrYSDrIMLVBN/5+M2jOFFDfLr6IA2otifRxpf+u+21cIsuJ0sTchb95U58wLUGb4KQuA5DigYBrtata+UhOLRHTiXCnde1kMwYGalqFRXCH2hUTqOVyD8Vpk4RjEbWgelqBVB4/eyoA3f021yRUgGdUUl4qlXwJ2jdBHQ/Yhaxa3m7oJxDv8DWPV3p5Il0XArmEJUqkWKRZHgq4iYPCyN50C8owfdYZkwqSlaPRxDh6fof1nyflfV3iXsu9lUeAz1Qhg7phuo1Khqp3vjs5OkpmavjAUxRQFja5D+SFRek7RttotkotTyU8+7IhzpAvR+uSZWsp2+SXeYBFCc2Ce/iRfYvDXuYhXZyxi1uaUDfvNwsyVUF26NOq5fknR7YDU/Pi/w0M9cFe5REkwXEGEk93EfZHBdj6VLEe4uM/UsYBcRDs2Oy4JisyTYq4h6OKe9GlMPZQ6cU+KYvR+8xj8uQxl8dYxKN7UwV+HxKSa0/7dqbKFdR7Ks9FIEEo9Qd4IxJEV3TcR7CNqGteopMb+gvGsITGLPc98BgQhaAg4bONOlyqEVSWejdJEfn6Igm0TSuQsq8I7AOWw3oMllGqGpG/S8iz4R0b6a8qSX5kvs8eCarT7A1ehgRtCO45j4nrMc87e/2p/9Sf2OKRAKpgsZAxXmqoIOUr8/9bDdOS6hCbOJvLL0N9UZpCPfm147Fz/fA7mYSHLN/642Y15q6/oete+EE+G8AhemDYCz1tISbIt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099006)(11063799006)(4143699003)(6133799003)(3023799007)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7ISWLoy1127Pt2sVAflxSaa6p7+mLO/EufiovZB/QZC6op+EfjrKAGCIjk1i?=
 =?us-ascii?Q?b1cOMLnwoD860d7ASE5jvF5zOl5Pdg5QdJVTtSjhnd3kB2ef1gC9KhswdCFS?=
 =?us-ascii?Q?rdbEEIP+Zx6cvdkZSBbPx5w+7JaUwBQeeXTs9bdXyxCnaKKEszAJsu6L/Cam?=
 =?us-ascii?Q?eggyAw5DXtN7PMcNJtPDxGHW7UIlZ01tgnoSQh7aCgD41pXM3Zo0THSvl3bl?=
 =?us-ascii?Q?oAqftudgWMj9/cL8SSrlTniKZDRPXuUiGWhObEhAv/xvPPjwv0u+2G3+6knX?=
 =?us-ascii?Q?saXups3Ak+JiG8xhHXq9XqLfSss3i17rPshKyav0ShgRkYWrJaS4MRIFljvl?=
 =?us-ascii?Q?rtJiNA+bnNGIyJ9to801BgNYMnxQpyEPip37hjP3TgexRgWvUbKxjTrABvJL?=
 =?us-ascii?Q?JLZq+rc85rymp9B2AW6LccDawwK+hooxhqSuevbxngJxxXeyOwLzjMfBkees?=
 =?us-ascii?Q?Gi+Zs9c2yiBVpSPMeMc06x2eOrfDv6JFTUd7ZLnE29F++Jx9JbwlPv3u8vPR?=
 =?us-ascii?Q?Cl5VGvDgsSzG3k3BKaWQNb6Q7NznKUgq/KHFJOHrq9nb1mmXgjyW2cfWPMNq?=
 =?us-ascii?Q?tTVSLGUnDiT4CQDqx8o4IvMOjwYB6Uu6O6jLJAmuafUfvT2qzmXj4mBBMkpu?=
 =?us-ascii?Q?Q0Wc+6zVy6Kt0/ogjl694eki6eY0ggRak1NqSAmQ67gboBQp+VImJnKN/jej?=
 =?us-ascii?Q?ECMDmeDceYhFlv4PaVzDzxtEE2Uvqsj6CJYFP5zW+HuzrgGO6giYjbJOsitt?=
 =?us-ascii?Q?PAzRlZ2D5PbTQeYiTPhY4fBQnYiISaVxtNhuaB/FjjmmKitPDaGR/UFPfUGY?=
 =?us-ascii?Q?4OiosxapeC+vpa9dpiXzv+TAlxyWWQ28FhTtnMY0158kKqHC1QZURRp6CmkB?=
 =?us-ascii?Q?fP4dFrdc9d9U7DbgdF51nTlTPmaOlgqv4fglmQ9WKmiXzwmQaIqX25lgcLl0?=
 =?us-ascii?Q?1d7ZMtPruhPmbbjPeNT869uhToYq2BOTgHeddTykbaySJ1EFc+xB/Cp2a3fu?=
 =?us-ascii?Q?68XHolxRzhTBaHiSnQWer5quzNk98XxbQ6iN6zeZga2tqDcy0fOnXRE5jEV3?=
 =?us-ascii?Q?CBH2UA8SyFwl2h4UWrH5l8w67UC+CH9/yPAr8DSd8whD75i/ghxtzL2szWHG?=
 =?us-ascii?Q?wf6OlvdASmLlFuaqG3tdlh5lbq1Hm1AONJkmM/fL5NIYanvJ14PIMd25CrM2?=
 =?us-ascii?Q?TKavXm4XlGyvDMkwO9o8d7GXLn1DRv/G5XD3WAJNAvAsDovpj7jG517wXlpa?=
 =?us-ascii?Q?S9NHmj/hWOxSb9ccvNVbYCzFuSiw1W9qpia2kw0JIwsTzdwaCVEaM6lzdOKT?=
 =?us-ascii?Q?hM3Kke07YcbUIY1tBmu7RRIQ7C3C+jIF2J5QVX3hDnnrcjtRuvclOvwIf4nZ?=
 =?us-ascii?Q?L3lbclZRAOt/AXcn/wRMtXe39Y+39zhS3P4EzZQP8NxKRwDbQeds+4zBzTkt?=
 =?us-ascii?Q?M99xsw1Vr6k5t/BxlgA9u+OayFEhZzh7TcfQsVPO/zJzCbiPtU24SRQXggML?=
 =?us-ascii?Q?j+5Z58NEl2T8P+/vkolCq1iaGj5F9e5RgrPQ6E/eIuj2QkWrQ8Rlqe+WP702?=
 =?us-ascii?Q?Ju5WP/FeysIR2TpDEcuJqfDPQeDojSTGiW/N+wuCS/GdonhE7yyzEtLpEs6C?=
 =?us-ascii?Q?ULZsnY2rJ0VFL5hJQ080wvSPDrjS2bGyVB8EF/DRr3O3HrWqbWIlnzuE3BEQ?=
 =?us-ascii?Q?BKORBskUyvH/djJMbZH1poZkXFTPEWAF6pBVDVAXUuylnN2s?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: a6/jSu4LrTK0bl+akkqQa2qAbtbtUswIUoqiIGAB3AVlrrHn/qHTIZXdA8OnTC8MJAoqUJrOKmpMEByIHPzaI2sXWbLGIVgS6V6WjskajOoQVAfjlt4F7HuJ5o4hTyYgX4yiPo/4xvZ/XNEgkvIOvShPs7alDGjr72VVN8GvddFevpA8QV4xncysDhSN17tf0+c/F/a0oHhjXwq4WSVJQcSoH2Ld26d+yuVS1Nf3/yUjiy5/RcFQmwgnKSqg0kFf7lpoFC3jthLZuI+hRFcu8RJE0yzmpikuwAZC79Q6fiD5ikfLbXhjzelnj7jv84zoCVZvItro9v/6JPb8nWX6Tw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edab8d3c-1a36-494d-be34-08dec508713a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 02:48:38.2692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6R7ZZBiV801kqsIa/KzGPrRQTpMyOR8aUd/4qfQPQ12FviEcKncM8xqvz4NO2COKKFtv2z63gGHWWzCcC8abFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6562
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: d3z <d3z.the.dev@gmail.com>
> Sent: Tuesday, June 2, 2026 5:18 AM
> To: Xu, Even <even.xu@intel.com>; jikos@kernel.org; bentiss@kernel.org
> Cc: Sun, Xinpeng <xinpeng.sun@intel.com>; linux-input@vger.kernel.org; li=
nux-
> kernel@vger.kernel.org; sakari.ailus@linux.intel.com;
> abhishektamboli9@gmail.com; Danny D . <d3z.the.dev@gmail.com>
> Subject: [PATCH v2] HID: intel-thc-hid: intel-quickspi: reset touch IC on=
 system
> resume
>=20
> From: Danny D. <d3z.the.dev@gmail.com>
>=20
> On the Surface Pro 10 (Meteor Lake) the touchscreen stops working after a
> suspend/resume cycle and only recovers after a reboot. The driver logs
> "GET_DEVICE_INFO: recv failed: -11" on resume.
>=20
> This platform suspends through s2idle: /sys/power/mem_sleep exposes "[s2i=
dle]"
> as the only state, there is no "deep"/S3 entry at all. The touch IC nonet=
heless
> loses power across that s2idle suspend, the same way it does across hiber=
nation.
> quickspi_resume() only re-selects the THC port, restores interrupts and D=
MA and
> sends a HIDSPI_ON command, assuming the touch IC kept its power and state=
.
> When it has actually lost power the HIDSPI_ON command is never acknowledg=
ed
> and the descriptor read fails, leaving the touchscreen dead until the mod=
ule is
> reloaded.
>=20
> quickspi_restore() already handles this for hibernation by reconfiguring =
the THC
> SPI/LTR settings and running reset_tic() to re-enumerate the device. Make
> quickspi_resume() do the same when the device is not a wake source. A wak=
e-
> enabled device keeps its power and state across suspend, so it stays on t=
he light
> restore path: resetting it would discard a pending wake touch event and b=
reak
> wake-on-touch.
>=20
> The non-wake path mirrors the existing quickspi_restore() sequence, inclu=
ding
> enabling interrupts before reset_tic(), so it introduces no new ordering =
relative to
> code already in the driver.
>=20
> This change has been validated on a Surface Pro 10 running the linux-surf=
ace
> kernel across multiple s2idle suspend/resume cycles; it has not been test=
ed on a
> mainline build.
>=20
> Closes: https://github.com/linux-surface/linux-surface/issues/1799
> Signed-off-by: Danny D. <d3z.the.dev@gmail.com>
> ---
> v1 -> v2:
>  - Only run the full reset when the device is not a wake source
>    (device_may_wakeup()), so wake-on-touch is no longer disturbed.
>  - Reword the changelog around s2idle: the SP10 has no "deep"/S3 state, t=
he
>    touch IC loses power across s2idle.
>=20
>  .../hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 60 +++++++++++++++=
++--
>  1 file changed, 56 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> @@ -784,20 +784,72 @@ static int quickspi_resume(struct device
>  	if (ret)
>  		return ret;
>=20
> +	/*
> +	 * A wake-enabled device keeps its power and state across suspend, so
> +	 * only restore the THC context. Resetting it here would discard a
> +	 * pending wake touch event and break wake-on-touch.
> +	 */
> +	if (device_may_wakeup(qsdev->dev)) {
> +		thc_interrupt_config(qsdev->thc_hw);
> +
> +		thc_interrupt_enable(qsdev->thc_hw, true);
> +
> +		ret =3D thc_dma_configure(qsdev->thc_hw);
> +		if (ret)
> +			return ret;
> +
> +		return thc_interrupt_quiesce(qsdev->thc_hw, false);
> +	}
> +
> +	/*
> +	 * Otherwise the touch IC may have lost power across suspend. On
> +	 * platforms that suspend through s2idle (for example the Surface Pro
> +	 * 10, whose firmware exposes s2idle as the only mem_sleep state) the
> +	 * IC loses power the same way it does across hibernation. A plain
> +	 * HIDSPI_ON is then not acknowledged and the descriptor read fails, so
> +	 * re-enumerate the device through the full reset flow already used by
> +	 * quickspi_restore().
> +	 */
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
> +	/* The touch IC may have lost power, reset it to recover */
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

Thanks for your patch!

Reviewed-by: Even Xu <even.xu@intel.com>

> --
> 2.43.0
