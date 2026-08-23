Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E163537F014;
	Sun, 23 Aug 2026 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787485550; cv=fail; b=YAS26QRa6iJb+fmxvgK/nvgy8uhKW2NfTKtgzIe5AmNTY4dTXMBiw9f81DhX/1fu0rb9I5QzOYVLfWAuwBGy+GZDjq/O+cYo/MqxZ9kuCiRlNHm5e/Ujc9U4lDHow8As1C78U14kBPjCXTgp6WHSpFp4+x/FtAkWIHCUZOErQsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787485550; c=relaxed/simple;
	bh=Xis4kGjrRBL4A9fbSIF3Nqrw05Lgr479oFB6cZS3NMc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Elf/N+gOgmH6ZMdJJfZlCKGaOX7p713VJTCCuV4q5HObHsr0X9kHmf3CQz8Z4h0yzlFfIBuOxTo9Ev39YKXlyTw9KMb25oG5GwnefcyMmxKKGvnlefzxRW1q6SUB+rkniPVOu0wN2cKdTZX8PZSW7MWyYwBWonIGzpfjrVHuIUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXGHxInA; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXGHxInA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787485549; x=1819021549;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Xis4kGjrRBL4A9fbSIF3Nqrw05Lgr479oFB6cZS3NMc=;
  b=jXGHxInASpJvaHVBVThOzMacH5qStC5auu3yKSKqqk2UwGxJrfR+ypUT
   8Q+QZHPpYewXWjGyPCgSIKT9HKCbGJU0FxQYsU9+NQ3djvozPn9GuICUG
   soVU2XW9q9Zq0yzbV2gxLDs8f0hN0SjnZcZdUUxJ+Cb6v/u6i7UTsZE/J
   HCil6XdEIlrnEX8UJ5qyZulqToOUnYe+ILJQUofkyAXtB/9oyxcTKvvhx
   Qip7h8I5PrIa7ZH+AJC7yJXb6aVkPjv5J/PTYmCTz9X5qpGk4s32LPbM4
   qAWU09OHS4a3qAs5/cNXdu4mLboQuAeY4bej5u928iA1ODnZZZjzqQNG9
   Q==;
X-CSE-ConnectionGUID: v682zGr6TrGPayqzdezo0A==
X-CSE-MsgGUID: ylu8uNvPQfGbDnWnfSU0tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="99119028"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="99119028"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 04:45:49 -0700
X-CSE-ConnectionGUID: smvUdzJHR4aSEWKfJpwcWw==
X-CSE-MsgGUID: 37vfuH9hQiKc7+FJEbGQHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="304949690"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 04:45:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 23 Aug 2026 04:45:48 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 23 Aug 2026 04:45:48 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.26) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 23 Aug 2026 04:45:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGy9u7tZUgBMuc0yeHBFG5ThpfqnfrjDBlnersYAN5TrqwF6rtvdJ3pO4tkqFnX+5ZKgz8lQYu+wTeIrWOdV5lwrxi4mlifXqsKH/AmA3PxpQkPKfiOGU3chqbE9Dw5AxsGjN866hh7HGQtTgBRVPNH0NuTpVLT5A+IUtJ6viO02jw+NxJCI+cKPus1EhnTFAXwWi0aDQ0DSns+BnbI0GL91NJubUXM7HJEi+YGXJYc8lfa9mL9n+ASw8+M00OzJj6IjsFUNsvndhju5F9OLzXH+gKZuw8P44CcBXbLx5wr+m1Q5bEGxJ45GxVriGB+CoDFt5W1QJ2lLMAb/KdM5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmTVwB0qogC6SsNzyc7tIcfD6aNPCd6SYCsgHKCDB50=;
 b=CJE3aazjkQ1vtjum51tO4LYwcZhDNSXwQPNAioljTI3Ao29YnTNTYMAaROTSYqfRUEv8KiJ1nPYBBjCGjmBZSbOUTF1qzgeIDCWlMP20tszWAgC2+cvtupSdEWrwHrh2vYD1O3RTZ3QFslDfshLpt1nE0gfdBEJq+Tfidfspmdnt55NUW9k2A7vLSne8/QKJS7OViBDDD7lKg6/t+t9F1iQc1DiBRZBBR5dtBbp0NJpnQ72wGBrrqNr+cSFxwosHorI5wz+8tCcaCGhs9ZbU/IoQ7YVrY8FerdhDrs0q8qzEqG069P4/Zlt4xckMaUFUz5YvQ/jjkIjP0YvuSYRrsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22)
 by MW3PR11MB4730.namprd11.prod.outlook.com (2603:10b6:303:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Sun, 23 Aug
 2026 11:45:45 +0000
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640]) by SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640%4]) with mapi id 15.21.0339.012; Sun, 23 Aug 2026
 11:45:45 +0000
Date: Sun, 23 Aug 2026 19:45:37 +0800
From: kernel test robot <lkp@intel.com>
To: Triet Hoang <triet.hoang.dev@gmail.com>, <dmitry.torokhov@gmail.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-input@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Triet Hoang <triet.hoang.dev@gmail.com>
Subject: Re: [PATCH] input: misc: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <202608231557.WwzKko7b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821024215.55188-1-triet.hoang.dev@gmail.com>
X-ClientProxiedBy: TPYP295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::10) To SJ0PR11MB5214.namprd11.prod.outlook.com
 (2603:10b6:a03:2df::22)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5214:EE_|MW3PR11MB4730:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f480d4-14d4-40d5-045b-08df010c1162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|56012099006|10067099003|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: 99KYowfis5xvxhbs9xlJv9DTLLXHqzLOdGa7sw5hIoI/utuisDfcImUCNHU1ypheihFWn+tNW7z1Pq81k1ASjAUiIxDJd5F+gNKiew+MokyeY7gkY3WXEkE6IXI68DF9dc/r2xHCdPmwn6qxqWjraZTih2nsElvb37dI1fpDugyacoWAusN+zKfavyZtGb/DLS3JSueBV3s63N8tk4dqYjy+yUv3adyhOh/D1/AkXYtObi0aNAZEitmd/zD7jP4xBHa87FrYhEEaACMoFn2/aPzlifVOtPJwcuHtqW8r/PKaBxM/IaADluXtAfgAhwXelTMYSNBPIrfWFIke9pwR4gisDtpU9iKK5+ORwBYjj3YzpPJ2GrkrCJQlQsUKZ9lcmP7F2fg14ACQXJLAh+6P3ymSgkoXWAYhjPeAkQylVT3M6iKVSeq4pzqaGbnjopyGB9YlsSbG5cEvqdkMYaHKROPRUrpY/pYXv8cOz/qSOQrYZn5kv4auDhgksRy//y9Szmp4HDOQcKiwQXhD7zx/ajNYCewqbvkU7c9MvUqSysgblwe/i6u90rsB+lcog9piqf+EaaBoM4NOaChb1joUN5P7jsuTdGyqWGpXJFJJ/e0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5214.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(10067099003)(18002099003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zamUoiitcThmeFgFLTY2KIcFqvEjJXMPttRiCT40PZDM/X6x+O8+Tegxfw4r?=
 =?us-ascii?Q?C0asZwGxmXpMa99xXat4X3SID6nrBTWrnXSgsDJREwrRR1ibv2wXbfOdvG2+?=
 =?us-ascii?Q?TCXO/HUfoQwtsF6S9yrwcq45QB7vtHkOpdP14qfDEFTPqZcUbWgfFI7mso77?=
 =?us-ascii?Q?Y+5LAlzu1fNi40zzQw0SVE4Vj2ZWZzWqzxffXOL38ilswLoMzFd6oidYmlFo?=
 =?us-ascii?Q?sQBKF1VyPe0XkflCMNf2eNRnEkDeaarOpNAS17B3Z3NuqTXzIRc/RgfOp0Io?=
 =?us-ascii?Q?JFKMe3KWfex3WxIbnCdaIEY/MtLP23pW20fa8d7wZmCiR8B4UlG4wt5S/fIY?=
 =?us-ascii?Q?ZTJ9OTgRktkZKTRA0k+bUszSdRJatZWcNRz8SYmdo2zy7lacH8ugaV5tj9MK?=
 =?us-ascii?Q?oHttNtsuWybq5PpcdMghDUVzlIM/SumAAlRe/ecX2gGkkEpbSi+ryyqaD92E?=
 =?us-ascii?Q?1vRxXuUHJgRo7EAPZtuqDrVTu2bK4FIwjug5HzudeHGTpJWAq56TKl7fxGGn?=
 =?us-ascii?Q?TQ7AYqvi8wYOk4MBCMDr3Q+Y0u6sML2Ui7iJ9XI6iCuj2yHDYSye24FBhswE?=
 =?us-ascii?Q?/U3axyyg/sKAfrPqCu0y9LEBf0uEJBC95EDXzGFEIK2T9t8kBxREUzm9zi+g?=
 =?us-ascii?Q?eL/Scy0MTu40Oqfw6itGFefS1LD4R2o3o4jLAEulzKbz2M7XyzgO9MKzuADN?=
 =?us-ascii?Q?8LgZgKeKg8rc+l2YIwBdZsIK9afbqpdoP/rbMaI1cTxj76+srMb6mmp7b6Ti?=
 =?us-ascii?Q?Akd1Zw1V5aMfX4JyWl9uW07JtEOmnWzFqnZiJqhFbMYZseS1dJHKTAhGGKTR?=
 =?us-ascii?Q?H9R8K1z+ocMuDLlCTZH5GHXPZy8UDBC2zylIoC419spAmps0OoNIBykfoxnl?=
 =?us-ascii?Q?Qbx97abVljKJj+fX92wc68n9I2oDPu/8IamIGlADn7aveO0/leLXOpDUKgmX?=
 =?us-ascii?Q?Jt/776RWIvdOQenH3RXo7QtzT0yHGIG5YfDI8tUBQVagkaAVQSLrvlFregKX?=
 =?us-ascii?Q?okq1JlM5FrP0xPcH41X66Ywmnc0JgN+46pnqQNmJMzYL60jSaqeBupOFQoYJ?=
 =?us-ascii?Q?59MqAZ6rcDdFvViVjwI/wrFweJsbKqK+sP9TKaPknMdjE//A5kQfPjcQGT10?=
 =?us-ascii?Q?2VRKjdOIupunm+l3uFCcJx0wOc+y9pRxK2+CANKr+WPHJRczt1Vw8IXGQrcA?=
 =?us-ascii?Q?DhOVuswHWHLNhYbxyzTZ8KeDBxSfvTa/ZRKT9upI9H7Z3wk4mKu4QCC2VufW?=
 =?us-ascii?Q?v3352tlmGvPOIe9DCCZN1j/OCObCGC0BfRFkTXsPHHxm+AOI6eFUYd2nnhVS?=
 =?us-ascii?Q?5jTwPRoALmoC8Sl2rUe7n4Qv8gsrH7/c9U08jc7cQwTFAblltqbSw20Nt9hm?=
 =?us-ascii?Q?GfKza5KvfxA7LzcePU7K8SKfnWCtv/YUx9GN4Nm0Znjpp8aEOpLDBu+jw3uc?=
 =?us-ascii?Q?skuhgDiJdWwUW3a4C5wj92es+DUawF9dPsIU3Ce0jiBBfcTtPoph4g9uTh6F?=
 =?us-ascii?Q?d5fHkOoSfuh3IF3jCP2jpTL2nuzIiQSkC1Er13Y2b835HUk3gEgpZ85ug8SH?=
 =?us-ascii?Q?9doHRQ5O6FEchnzHQg9qiM0tC9gc4br0kAhgHeSua3wRg6QhDypdUKXAwXq2?=
 =?us-ascii?Q?WLVMpmnvC4Owa830QWHqjYAeL2WpwGW3msCZnOIJpraYKXhn8MUhaQKfmnYM?=
 =?us-ascii?Q?lY5kDlHz5Crl77CzwoBtidLZFfD54V+3NgBMzPAujb36EH8Ta1QmBNsnJaAM?=
 =?us-ascii?Q?tS8xClwUgw=3D=3D?=
X-Exchange-RoutingPolicyChecked: tQF6WTUMI5Fd8TVGTgcxmPfE6IahtX6rsFzAqQDHUu9/+DnUU8KijtRu7K/WjG7GwcgUiKihf6g4hTW4uSLuRFkusWavxiULG/BYm7H+Ty00/X6+BghogvHDs7wdcMUshdAGdUZOD2gtt4xZzwQr+DS8sWSbyEPtiGx32xY3pnuDGjlU4ca/OD4I0Gtk7ORnvWJDkFqKFTng4DL1ADkQeFGjPUhb5UQxhMxcKHebz3P9llFR9v8JPQwH4Yz+3Vp7jD6EKK3Ilr7h/Ouc5NwhoA+kt946n3MPyn0dwuKgwjTd6JPa/b3G6m5Lnndv/9tNi+dFWL+VXy1MFVYevihLqg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f480d4-14d4-40d5-045b-08df010c1162
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5214.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 11:45:45.5051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0LL3uZZ2AVFA57nL4ALQo72GMG7uxVdE+/tz7vlSYfPpoA1/um46PHD0as+ZF8XoxDWAl4BFNykA5/PlQlnpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4730
X-OriginatorOrg: intel.com

Hi Triet,

kernel test robot noticed the following build errors:

[auto build test ERROR on dtor-input/next]
[also build test ERROR on dtor-input/for-linus hid/for-next linus/master v7.2 next-20260821]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Triet-Hoang/input-misc-Convert-to-DEFINE_SIMPLE_DEV_PM_OPS/20260821-094215
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20260821024215.55188-1-triet.hoang.dev%40gmail.com
patch subject: [PATCH] input: misc: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20260823/202608231557.WwzKko7b-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260823/202608231557.WwzKko7b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608231557.WwzKko7b-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:35,
                    from drivers/input/misc/88pm80x_onkey.c:10:
>> drivers/input/misc/88pm80x_onkey.c:50:53: error: 'pm80x_dev_suspend' undeclared here (not in a function)
      50 | static DEFINE_SIMPLE_DEV_PM_OPS(pm80x_onkey_pm_ops, pm80x_dev_suspend,
         |                                                     ^~~~~~~~~~~~~~~~~
   include/linux/util_macros.h:136:44: note: in definition of macro 'PTR_IF'
     136 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:315:20: note: in expansion of macro 'pm_sleep_ptr'
     315 |         .suspend = pm_sleep_ptr(suspend_fn), \
         |                    ^~~~~~~~~~~~
   include/linux/pm.h:375:9: note: in expansion of macro 'SYSTEM_SLEEP_PM_OPS'
     375 |         SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:417:9: note: in expansion of macro '_DEFINE_DEV_PM_OPS'
     417 |         _DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/input/misc/88pm80x_onkey.c:50:8: note: in expansion of macro 'DEFINE_SIMPLE_DEV_PM_OPS'
      50 | static DEFINE_SIMPLE_DEV_PM_OPS(pm80x_onkey_pm_ops, pm80x_dev_suspend,
         |        ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/input/misc/88pm80x_onkey.c:51:26: error: 'pm80x_dev_resume' undeclared here (not in a function)
      51 |                          pm80x_dev_resume);
         |                          ^~~~~~~~~~~~~~~~
   include/linux/util_macros.h:136:44: note: in definition of macro 'PTR_IF'
     136 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:316:19: note: in expansion of macro 'pm_sleep_ptr'
     316 |         .resume = pm_sleep_ptr(resume_fn), \
         |                   ^~~~~~~~~~~~
   include/linux/pm.h:375:9: note: in expansion of macro 'SYSTEM_SLEEP_PM_OPS'
     375 |         SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:417:9: note: in expansion of macro '_DEFINE_DEV_PM_OPS'
     417 |         _DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/input/misc/88pm80x_onkey.c:50:8: note: in expansion of macro 'DEFINE_SIMPLE_DEV_PM_OPS'
      50 | static DEFINE_SIMPLE_DEV_PM_OPS(pm80x_onkey_pm_ops, pm80x_dev_suspend,
         |        ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/pm80x_dev_suspend +50 drivers/input/misc/88pm80x_onkey.c

    49	
  > 50	static DEFINE_SIMPLE_DEV_PM_OPS(pm80x_onkey_pm_ops, pm80x_dev_suspend,
  > 51				 pm80x_dev_resume);
    52	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
