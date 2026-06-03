Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011031.outbound.protection.outlook.com [52.101.52.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2AB33EB01;
	Wed,  3 Jun 2026 06:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467648; cv=fail; b=V4kHUHdQlRnynrf7pHvpnFcH064CHzmznCFhPyj2LUVWVeGQsmVa21kJge/biU6Xv80Rgr6kCMuuqcINBfMsRYdOOggTwb0U8exrOw0jzLUrrC3yO3Uer2Bu1BiWGmm1YtC+b54hm3ysW/DianLUaIKBEsKTc/RwrPx7IGcc7zA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467648; c=relaxed/simple;
	bh=pCfSYdMlitSGxntVIY4Mcj/LbUcgKWT5wPx2cn6j6WE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cGmY1ZW5J7FQJt60ERn0gZStvth/C3VLiDIuS0TZVsxPWZae5SMvZLuyeixstc6HHxKMbgrzdIlOK26YvBMtQH5OMWulq8bqRvQYym55JKieH4DbrjpOQ41XY5AgHPJoK1+p42bUSDIGuJkFmNx3ks0RMW3ZCT3qauB3gkUgn8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HnE56FSZ; arc=fail smtp.client-ip=52.101.52.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HnE56FSZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7SWcZsElTplwktRGYSvmFLIm+DCzuxOUyUMKeTErEF4NGf0ZbOT0cgv8CefJqKc50yKDj3fadI/mVL+O3Ijm+tGNFHwk9pi7lWu6g2RhRWpfOI2/1FxFNepKtucVlkMZoo7p3N0Qy+e17N9e6/ibSKfrQzo0E8BTDLAFCSihNkGMk1rxtfyOhfTIzXhNv6wRflAAwfGAY8mc92fQgIBJC/ceRL+xLiKmuO3rLjQt2lLUkYpgBNenuVvZgrpZFqryRlaGgRDOewN2oH1ukPvrvaF5cwVKEGgXzuVNYHzfHa7WEDKeXnkShHISFgdN12ZankhyzfbzizewYgl2CkIOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KP5CuegUo0vmnUG/QwGEHmqP3FWeO3jprWizUSFfE2k=;
 b=vdSJ4fd2MbX5B6fuLFcfPdXx3UGhY4x2TXC5VAqsOjVacVrURfaAf77Q82us/wt3T+DObdZB7HJEcKnW1MhvhMuYhrMxO0RnsNqQGtTRuilD6clSvXwbMHDLz5dPKNutSJNLlufdNv2d2fhMiTb/e0lq/Oq90LTMM5yAJg2sscZ4NbvV5XKKs391IvOzdHVkvqPiOeeOQA3qIRU8wc5z24UPgMvUlQPUVsjKxAyNjLg/quGZ0qUTURGTMde9Caz+Il8kbRkVPxpij8biQTl8qWX6xOql44WX0ArdKt40MKeVrHoNKjVC0QHyJP7vFxLw/oe+APv/qFjYDnnVo64e4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KP5CuegUo0vmnUG/QwGEHmqP3FWeO3jprWizUSFfE2k=;
 b=HnE56FSZZhmzJAKbXc/Njd8GjkeHzsKINnr38u860PJpgUllUTAJ1vKVvqzCWyB5Y1j+2DaDNNqfRyvh56BQy9u8UiDuJgs+KOdgDJvH9e814ryrSAWPf26Hphuwz+g1ABJOWwJCvY0uPICsxxEGgROjPI3qCOVV9smjNPWXveo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:20:43 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 06:20:43 +0000
Message-ID: <d6f08a89-ed09-4c14-a0f8-261bc063af77@amd.com>
Date: Wed, 3 Jun 2026 08:20:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: xilinx_ps2 - remove driver
To: Rosen Penev <rosenp@gmail.com>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <20260603054217.442016-1-rosenp@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJn8lwDBQkaRgbLAAoJEDd8
 fyH+PR+RCNAP/iHkKbpP0XXfgfWqf8yyrFHjGPJSknERzxw0glxPztfC3UqeusQ0CPnbI85n
 uQdm5/zRgWr7wi8H2UMqFlfMW8/NH5Da7GOPc26NMTPA2ZG5S2SG2SGZj1Smq8mL4iueePiN
 x1qfWhVm7TfkDHUEmMAYq70sjFcvygyqHUCumpw36CMQSMyrxyEkbYm1NKORlnySAFHy2pOx
 nmXKSaL1yfof3JJLwNwtaBj76GKQILnlYx9QNnt6adCtrZLIhB3HGh4IRJyuiiM0aZi1G8ei
 2ILx2n2LxUw7X6aAD0sYHtNKUCQMCBGQHzJLDYjEyy0kfYoLXV2P6K+7WYnRP+uV8g77Gl9a
 IuGvxgEUITjMakX3e8RjyZ5jmc5ZAsegfJ669oZJOzQouw/W9Qneb820rhA2CKK8BnmlkHP+
 WB5yDks3gSHE/GlOWqRkVZ05sUjVmq/tZ1JEdOapWQovRQsueDjxXcMjgNo5e8ttCyMo44u1
 pKXRJpR5l7/hBYWeMlcKvLwByep+FOGtKsv0xadMKr1M6wPZXkV83jMKxxRE9HlqWJLLUE1Q
 0pDvn1EvlpDj9eED73iMBsrHu9cIk8aweTEbQ4bcKRGfGkXrCwle6xRiKSjXCdzWpOglNhjq
 1g8Ak+G+ZR6r7QarL01BkdE2/WUOLHdGHB1hJxARbP2E3l46zsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmfyXCkFCRpGBvgACgkQN3x/If49H5GY5xAAoKWHRO/OlI7eMA8VaUgFInmphBAj
 fAgQbW6Zxl9ULaCcNSoJc2D0zYWXftDOJeXyVk5Gb8cMbLA1tIMSM/BgSAnT7As2KfcZDTXQ
 DJSZYWgYKc/YywLgUlpv4slFv5tjmoUvHK9w2DuFLW254pnUuhrdyTEaknEM+qOmPscWOs0R
 dR6mMTN0vBjnLUeYdy0xbaoefjT+tWBybXkVwLDd3d/+mOa9ZiAB7ynuVWu2ow/uGJx0hnRI
 LGfLsiPu47YQrQXu79r7RtVeAYwRh3ul7wx5LABWI6n31oEHxDH+1czVjKsiozRstEaUxuDZ
 jWRHq+AEIq79BTTopj2dnW+sZAsnVpQmc+nod6xR907pzt/HZL0WoWwRVkbg7hqtzKOBoju3
 hftqVr0nx77oBZD6mSJsxM/QuJoaXaTX/a/QiB4Nwrja2jlM0lMUA/bGeM1tQwS7rJLaT3cT
 RBGSlJgyWtR8IQvX3rqHd6QrFi1poQ1/wpLummWO0adWes2U6I3GtD9vxO/cazWrWBDoQ8Da
 otYa9+7v0j0WOBTJaj16LFxdSRq/jZ1y/EIHs3Ysd85mUWXOB8xZ6h+WEMzqAvOt02oWJVbr
 ZLqxG/3ScDXZEUJ6EDJVoLAK50zMk87ece2+4GWGOKfFsiDfh7fnEMXQcykxuowBYUD0tMd2
 mpwx1d8=
In-Reply-To: <20260603054217.442016-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0081.namprd05.prod.outlook.com
 (2603:10b6:a03:332::26) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DM6PR12MB4172:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0c54a0-5636-42cd-3fff-08dec1383dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	AakEVG5MgM2vtlJhZgUIIxQtdWi/VP4xj+q/kFD0Q5ljJ7CktOLTFqMATi/IW/ccUm1boAU0HP2m6ORWdUwpt7YQMA+2+1VwyJ7SOVOmLSC03tjYovCeSII+XtrFWkQe8ED0HH2lU3ZC3BkjsLdF2nCR9ozH4+pGDvh/9Q3x6XpxhGXjCIoHKCbSLb479k/f9Rolm1U67KlMpznY1YforiZw6bsJP3y7QHfjSdEBx22Q7qF3TMaIbcXbHw3GdsnlBErQd2cwn7YgWoA15nVYIoxYwe5TKqd8WSvfwsi0vL50awY8GoXhR1Cquia6znKiAUTe+8dNlFv14LJNbZELRkHE6HTO6MdfNrirc8mJuiNf7JNfDXAQAdKozJGJzQegfAsHGDGnLCcMlhp/96yUWw+Zpq5zRvmqhLNTPdlZi5bQ/q92YwAbxKVpB2zGoKwZAN2MSkfm571t9P5IX+jc0EsIEdYYmjTUNVGK1UstYGjCwueLHEBpCykdcBASF5+dxdaQekBk1vEKovr30e/xB9wc/W0QHoOAI/LvTlyL6/HuFS7LwyWaIo5fxgqn39QZELCYv6VJzU8WOJZr29x83+5cd5R0T4sLODI5oQzZBKLoHlowHWkntRmKqnZzYi6L27D1nForuAiPObB2jxS6UiDRa5qSzKArItgLgDDefJYsSnnZkfQXDHzT+juV42A7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099006)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEpBVjAydkxZOFQxRG1ZeWNCODJSVUs4Z3ZCZWpIWE5kYWFSenYzZkcvTVJJ?=
 =?utf-8?B?dStxTEVGVzJSeGVnUVhUcmV5WjRWUDFjYlc1b3ZTN3E3bU9DS0h5V05BUXNN?=
 =?utf-8?B?ZlFuSHA5Yit4Q081a3hOZ2Q4YUJZcnV5L3V0akZQVEphaDV6ZFZLSGlkSkRI?=
 =?utf-8?B?aFFBZDNlc1h1VHVIOHRCUG5renpnY3o4R1NRYU5RZUR5YlZLeUlLNXNraFBO?=
 =?utf-8?B?Wmd3dUU0dndGaWFSQm1hWXd6UnhDWUlqclNjUDVmMXVETFVnTXZKREFOei9s?=
 =?utf-8?B?dzVQWUEyVlRRM1NmeVRxR1FFcUMzMDk5WEYvcVFESjd3RGQ3Vng0bVlMSDZw?=
 =?utf-8?B?YUpLTlRzRmdmVWE0VEdUZWJHb2piUVZGQlg0d3RjamY2SjRTZm9rTElzUjJ2?=
 =?utf-8?B?Ymw1WWVnZnVmaGUrbEpvMEI1Kzl6dDV3RGhiN0x0Yys2VzZxUnlXTEVzNHFP?=
 =?utf-8?B?TGZoWmFTWkVCUm1GSXgvWHdXeGM0clB5Z0tRUjFDcCswbDRhVnZKcVFjTnE5?=
 =?utf-8?B?NXNoTkNicjVsV1JJeFNqN0ZOWkpwY1lKNFJ0VzFxNllUOHVIRUZWK0wxbGdV?=
 =?utf-8?B?cHdnT3JXTEZ6YnpTQlVkbFFYcEIzamZnZnNtV3RaMnRMcDkzem90aS80ZTky?=
 =?utf-8?B?cEpLZHZhQTRDc0FqUVkwaG9kTU4wQitTcHYyL0JFbW9lamI0b3lBem5vSnFZ?=
 =?utf-8?B?eThXdEcwN2VBSHFPSDExWUhlOUxVTytVYWZQT2ZNRjFBK1k3WDN6QlAzWDUr?=
 =?utf-8?B?SUpIYVZBaHJaeGIvVFhkTzVjbEZtLzhpOHRzSUY3OWUybDZwQzZHRVdJRU1R?=
 =?utf-8?B?MlYxVzhhSzhPejZTRFE1SGNXc3NFYW11WVl0OHQ1SGtDMXVDTVpYQk8wQWNj?=
 =?utf-8?B?ZmtDYmIzbHUrUWlBZHh6U0FHaWd3Uy94Y0RZK20yZ0FTdC9jRkEyL01NZU9a?=
 =?utf-8?B?ZVc5Ym1ZVGErcFYxU1pKTWV1MUFGcE9FV3BTK3FJOG1LUnh6dkxtMXBMRXZn?=
 =?utf-8?B?ZkNHeWFPUnc3dG1KUElpN2xsQUIyeEY4UGk0cm1RT1pMVjhIdktaeVA3eFd4?=
 =?utf-8?B?bVkyV0xZUUZVYnhaK0FtYlNnNDFWaUJKenloMGVNYnFsYm9mYzRPd1FxUUlk?=
 =?utf-8?B?KzVXdDJ0MzRvV3ViSVgwdFJMV0F0RERtV3gwV29RQmpYU2dQdWQ5REFLbldR?=
 =?utf-8?B?dzlPZnJTbWNLaHU3N0xqQVlIY01hMk01VGR6ZGZCZHBkS1ZUZ21lS29Jdklv?=
 =?utf-8?B?UTJsY2h0TDZVMjkweEJLRmh5cHh0WXFkOFpzcUFkUHlRdjFZQmNFYm45ZGw0?=
 =?utf-8?B?TjJNdVZSVzN3MXdsdzdBTWRnd2dtUFpJbTR0VnpOZWpnTVlST21yTDJEVnBj?=
 =?utf-8?B?WjZDZnJXTHFPcG5tQ2JxK3VFQ3ZYRmd2eHRIMmFxbHdQN0NzZ0V3TE0rc204?=
 =?utf-8?B?YWZRM29ZV2ZpbngzbS9VYTN1bnNHVXdTMTcvd0VRWWt4QU4walBHRG5GcEk1?=
 =?utf-8?B?VFFlTFdsMUdCaWpEMXI5SjRRTnRzVEZudDJ6SjRoTStSLzZFS3BFSm03a2VM?=
 =?utf-8?B?dnZmNkQxVlpsUnJ4Y3RDcEhWZ0g3YVpkZzhyeTZJZnkzZlJvQVZJTEdUQldj?=
 =?utf-8?B?Q0IvQ1FtMGZzSDVNMk1PdmNzN2ZFZjFUempvVEZ3cUI2akx0SGZHaUhGUW5k?=
 =?utf-8?B?RmM5Y2Rvd0MyM0VwYit0cWJpeTJRdUJjNmJFWnNoMDdiUkh5OXZtS1NXdTA2?=
 =?utf-8?B?MFBobVBuc2kvVVEzSWVWNU9tOURVVFRVZ3hmRWdTTUw5akFYVUx6bWF0ajN2?=
 =?utf-8?B?YWplNVhHR1ZVWG45SVhBb3B1QUw5K1laOUtVcUVrMEVqeDByYmdYVWRPVmNE?=
 =?utf-8?B?ZForcGJxYXl0OGphcm5MNTJGTS91S2ZPOHU2dVhHTEszUWEzbkJIRWlWbFFM?=
 =?utf-8?B?b2JTSDAzci9zd3N5OXFwTlh0V2NSek1uK213a2xvSW5BdGtHTTEyMTA5UTY2?=
 =?utf-8?B?U0w5ZUdkRmQ0RlhucEM3NHUwcW1YMFJtOTNqeUNmbGFoN1BzQmNHZzBTekxQ?=
 =?utf-8?B?V2h1bHdSdW1pbC9zTUpUdXUyNFRBaTVwbGZjMitJUnhYQW1PQVB5WlZkNHlz?=
 =?utf-8?B?cE9QSDE3cElGcTdYTjU4U0p6aHVBRmxnV29QdTR4Q29EY203SEdFaU9uejJ2?=
 =?utf-8?B?U0liVEEzejhnTVN1aWx0c1Z1ZWNudFUvR2ZVOWdMb3FzaDQwQmlSYk11QU5i?=
 =?utf-8?B?TTR5cmFLODhQcEpBSEJtSGZyKzRPR2dWZklqWTdSbGlXM1FvdXR4SVRraTg0?=
 =?utf-8?B?N2xacm0xcUVBMkZKN1cwWi85bzRTUVdUQ2Rwb3pUNWZHQ25OOEExdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0c54a0-5636-42cd-3fff-08dec1383dcf
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 06:20:43.3655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/3WU53yeVba7rzMPbjIsL12Q9Kh29LHOlYvSaM21SzAf4c8ogi0ovDL//CWgYJH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172



On 6/3/26 07:42, Rosen Penev wrote:
> Remove the Xilinx XPS PS/2 controller driver. This driver supports an
> old Xilinx EDK IP core that is no longer in active use. The hardware
> is not available on modern platforms, and the driver has no users here.
> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/input/serio/Kconfig      |  10 -
>   drivers/input/serio/Makefile     |   1 -
>   drivers/input/serio/xilinx_ps2.c | 363 -------------------------------
>   3 files changed, 374 deletions(-)
>   delete mode 100644 drivers/input/serio/xilinx_ps2.c

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
