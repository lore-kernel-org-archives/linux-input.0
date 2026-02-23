Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013010.outbound.protection.outlook.com [52.101.72.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9EF3793B3;
	Mon, 23 Feb 2026 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883859; cv=fail; b=mGrRNtwe4FLkQt6FWluqCt9Aqk0NxUSgW3wdH0qzL4xFSCjI5ICkmKbnuz4Gkw1EKTzjjOH3pEEDODC7P5rtD4RWTYy9IxCM3vCKibvBb5au5sNHpdEJtuORlcORnIlrnT8Sap7Nt2PsoyL6e20aBPpZprl7BhshyLbmev6IScw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883859; c=relaxed/simple;
	bh=6qfJ9WWS6daqiUJ4w6kMAp/WE7immRPNNCaKwV76uVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t/YrbKPndU0VeSvjWiMbWGdUCcjXSPvT7gu4xaGKArWorys5yeNNTjaZYnhC9bMff8bkItVhq8l31zWxpKlLAutuv0kEftkJtjIhMSmiYXO0ufigFzv0LL6YGxOhH5HpdJYyKn2bIprA11gFe/Tt0Xp4AD/xZ5N10AmA59V//nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kqn0zHUZ; arc=fail smtp.client-ip=52.101.72.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kqn0zHUZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0zfx4j7GgVcnOyUvNE+3Qokn3UxJLm2kqPDdcIz9lqFXboA9s7ULre8lAy/47e2LU/JMg/efT2Mnp7LSZ5N+2zviW27anE9vErLtSQR5UwfS4o9yKYowloDttesO2hzNn3YXCVqZcipvphq90wGVSCDM/XESZeoFtT11UQM8BiNl7Eej9WC++58gs3n3L5UWztcBdCY33UROVGa33CfIHNKciSDG/al6AbX7pZZ5fT9BbWOPSbX45Ro83mHs4eBIEzJYxhF9XA5AWl2nd11OWdEoZatzTQ1/9//tbpYPwG1B1DXjb2Dv/IlVnZdfecR+51qkTLE7yGKuqsum5Fw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=et1CwgC+yfj/pdXr2bjleZfROZTcg9bz3qWYKx06EJk=;
 b=IMd9nGmVzpUEvkoqAXzhbjy3Da6dI9+d3d6pzOXgkUJmvNQ/efK4mFt69I93xo6Xhf2tmYWsXjsMZc9N2QS1avMqt7nLjF3vtQR+K+fc8JfGAPkqbKMNjb/LAl7Axqm0yYHT2Upsf6acTCKltIGRxXWKfC1Rklb6ETw8Qr6NX3iMw5z9cDVH+hp/vL+QpfrV20lsdrYbuWptyM9Ceo/UMcgLhFwq+0XhEROBEijQxnQxKKYJvKOwWG4XJBxg2+P5z5DlLMjb9hUUrStJepdzsTJ9iwb7J4wZd8f3sDSVVwlTrGtqjc9P805gqBNPOI28yDHcFbQL7vGYJSs6sZbylw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=et1CwgC+yfj/pdXr2bjleZfROZTcg9bz3qWYKx06EJk=;
 b=Kqn0zHUZvcqWrkg1XxDS+ebVcMed0xiwsuL1TBYgeWWhDCRDBHi6XKqAauuq2lmJ5oMuMo6EoNecJZs3fl82nB5x4IZqfM3EdpB0qmXFM91ojqUFSNOZ5eptA72GQjDGeuxLN/lyyKvNFLGBS1txCX977Tx1dRhdoT2IFK0ZLqX4wVm+aJ4kW6711gfgEcHC2am7rVFX0d8MwHUud+fEvbDDnC6mendwmA5jRXny46K4nV7jluyFG1oDR0phCcO4A5sWaFczqcQZ8XuaCYWdU5tQQ32I4sNlbsHaftBhlH/YDS863ok3Cn3SxJqOil3Pjp4RyGE2CSsvnYbooBK3Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB10117.eurprd04.prod.outlook.com (2603:10a6:102:454::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 21:57:35 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 21:57:35 +0000
From: Frank Li <Frank.Li@nxp.com>
To: linux-kernel@vger.kernel.org,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Frank Li <Frank.Li@nxp.com>,
	linux-amarula@amarulasolutions.com,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	Jeff LaBundy <jeff@labundy.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org
Subject: Re: (subset) [PATCH v6 0/6] Input: imx6ul_tsc - set glitch threshold by dts property
Date: Mon, 23 Feb 2026 16:57:10 -0500
Message-ID: <177188168376.790326.11895241482537283251.b4-ty@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923143746.2857292-1-dario.binacchi@amarulasolutions.com>
References: <20250923143746.2857292-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::21) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB10117:EE_
X-MS-Office365-Filtering-Correlation-Id: 3633a080-5fc9-4651-ddf8-08de73268d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVVCWUZMemhyVGNSVFUxZXFBK29Ga1hLS0J6cE1EaFZlbU5ZN2hVUlQ4eE5z?=
 =?utf-8?B?aG5LV05IOTlZQTNCTFpCenA4WE8rRGpzcFk5MGhNNC9PZnpTZ2l2RVN6NkY4?=
 =?utf-8?B?RmVMSmUyQ3pJd0RKQVkzbXZDZEtyQU5hVUdoa1ljTjN4RmVLRWxGdjVJQWEz?=
 =?utf-8?B?L1lHRlVHcEpBOXFYZ2M5Qm1Sak1kRlZFWVRTUmJsNW1nL0RmVnJma3dOdjh6?=
 =?utf-8?B?RjlqZ1lHbnNPczErckpiM05DQ3VoMU81WXd2RjBzYmdVcGZaOVM2eHBMVFcw?=
 =?utf-8?B?Yi9OTTBOSUpUeHNVSDJSRy9CbGZIZTQrRFdzbnNQbHd4WnVVNU5zOEFLbkx6?=
 =?utf-8?B?ektIUkpHRjUvRDVmYkw5dEcwM2VobjRLSXp6aVEya0N4RWdydUtlemN5dWlm?=
 =?utf-8?B?NFhwVmpYczFOMDBtWnpXWk5tWHBTOGZXNVJISFhVUDZNTFc5SXhOa0NRcXhn?=
 =?utf-8?B?aE9ETkV3b091NnZUOCt1N05BRmVxZVBSemc3Vk5vcGZocnRJZE8vT0FQZGIx?=
 =?utf-8?B?dXFPRXMySEFnS0R0cGExNFRwY2lraWZqdlNZZHFFOEhaTGNWZk5CQTlhNWZV?=
 =?utf-8?B?NmZFclJLdmlpR3gvYVBud3JZV2swbWlRSzE2VXlSTTRUanBPSWZ4K21sUWV5?=
 =?utf-8?B?MGVBL012UTZpMy96QmV0bFJDRklnWVRuUU1va092YzlwcGExRGx0OHY0UEhv?=
 =?utf-8?B?eStFR2xUejBTUEROZEpaQXZZTWNIeGRhbkhZak5jRWx0NjgrOTlDNTc2NjBv?=
 =?utf-8?B?ZDh4cDNlbHJwaHZ5OGQyVTZ2cEhwaXBTeVpDUUY1SGJOdGZORllPUExla0Vt?=
 =?utf-8?B?MVhPbUdsV1pXMjc1d0VaQ3FKQzVpOU9Kc0lZSW9qL0dUeHViemdQam82QWdm?=
 =?utf-8?B?bEE0ZlZaTnYxZzc1OWt5N1lMMWEzWjhPck4yQTVKMGlVdW0yZzA1TTl3aWlq?=
 =?utf-8?B?MVBIbFdEdDkwM0NhRG5qNTcySXN0ekhOaVRidUZDaXpiYkZ6YWNrOHBvYzhj?=
 =?utf-8?B?aTE1UTlMcjlnRWR3UGxyTUppWmUvdHBZSlM2UjFmdUFrYkczc3ZjYWI2U25o?=
 =?utf-8?B?cHFqbmFFMWZJQVdHanNiekIxZ1NBSkRid3VuNHRsOUMyNm9PWG91bng1cC9j?=
 =?utf-8?B?Wjk4SUNVcm1idWtrcWhjYlVBVkRtSEJnNXdmdFF0OSt6TEdTcXppbVNXUldx?=
 =?utf-8?B?alE5bUtHaDRPWjhGdmVNNUJ6a25XVkdxaVR0cmZOWEFvaHNyOFdBQjkzeFJk?=
 =?utf-8?B?b01OOVYxRDliZ1BmR3FKUHNPTXlaVEhabEZhbE05OThqRFBXZzRGN2hkeVpl?=
 =?utf-8?B?NW5nbzFiRVozekkvclppWjZSU2QyM3dtTVMzTURTWTk1RnN3RCs2dmwyS0Yv?=
 =?utf-8?B?bEgwUXpEaTJJU0NsTER0RHZvMzhZZlprMFY5ckJiR2J2YVk5a3lSOWtMRzl0?=
 =?utf-8?B?QzU2ZTE4YWt4ZTZLZmlXNmxiRVNPZkFVQ2lRWWNBUXpKaCtIYlEwYmRqZnR6?=
 =?utf-8?B?aXVZMzl3eElWSDZFSmVCaHZ1Q1lKdHNaZEpuZkhHalhOaDNFT1JHbFY1RHNE?=
 =?utf-8?B?MFoxREhoNGlSYkFGMUJpd0Z6NWUvVmY0MHRmeUVGVFNlQU4zOWFlYWk0UEFz?=
 =?utf-8?B?Q1c3dlBBV3V5LzY4ZkI3dXNOTVdOZ040MFRvWTFnMTRiV3FIcldoNHR5WDlx?=
 =?utf-8?B?aTBEWTUwL1ozOEpkYTRvWXEzaHVhN3p1ZXowNjBkNTRNb1VEcUNQZlpWdFFI?=
 =?utf-8?B?cENCMmpGREt6Mk43SDE3Y1FUYnpPaVlPME96cE4vNCtuUld1TmVXbFpEWmdn?=
 =?utf-8?B?dnFjUVVhZnNPSEx4TUtObXlLVC9XR2lyWFMrcjFIY3lYK3E2TGxFSHoxZVNZ?=
 =?utf-8?B?UzZsMmk4Q3J3YlAxdjJJYUYvL3pkSkszT2RMZ2V1VzFwU29jQnNDeStKbklX?=
 =?utf-8?B?RjA3NklQRVdIQ3dmNVhIclEycmkzWFlZRC9mQkZDaDE0V1lLYXY0ZHB0czlZ?=
 =?utf-8?B?RGYxNHp1ZmlSYjljSThiRHREM2Z5Q2tQQXRQdytlRDErU0ZZWG4weUtjM24y?=
 =?utf-8?B?dGszQVo0dlN5aTVMNGdXVThyZ24wTnBvTmxzLzdlWGhTZzAybWVERHh1MXhI?=
 =?utf-8?B?VTFGVitINlBGZ1A1aDRqejNzTDNkQmZMVDkzQjgwTE1uWjFVZ0RBQlZhSldZ?=
 =?utf-8?Q?u6qPnz4pfWdUrKKpBk1TRJk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0I1bXRJWVVodG9VUWY3WXc0ZWNpd2pQa3R5ZTNFNTFMcHBsQ1pCeGQxMUNq?=
 =?utf-8?B?T1AzaEh2S0RXM3Y4NWRTdlhSSVJURTM2WTh6bmE1ait6djhtakxPZjdUTG9H?=
 =?utf-8?B?VFdWWWVIY2U1T1Y2MGNUSTJhM0g5NGwyUnVhTlRoZTdBTmxWTW1NWFJsUUJz?=
 =?utf-8?B?M3NqcURFcU5VZVpCQnY5YXhEbWNQWUNZNStSK2VUM2U0Q3FuWFgwT3VUTTVq?=
 =?utf-8?B?emFJRTBnUnljNGVRNVVFOFJkMGpESXUveGVMU01CZC9JVFppaTUwWlJld0lL?=
 =?utf-8?B?dXZwSS9HUFlvOXlRMDR4WldxK1diRUN1aXhveDUvVnFQTjUyQXRwYmpHYitK?=
 =?utf-8?B?SGdpN2llUXRFajBBZy9WQzhlUzFsWjUreXV1bldPTndZelpBOTcwNWxVL0tT?=
 =?utf-8?B?VjZYSVFIOFh0dzQ1K3Uvb1NzcS8za2pyam5DYkRMMXcyZTczSVZxKzk5SWtI?=
 =?utf-8?B?bnJaK2ZwOEZBZmhxbHd3RCtTZWFjVWlMMllMNFJlU3pPZWxDWWRVR1F3MW4x?=
 =?utf-8?B?REY5NTZ1ZlgxUFdKYlNvK0YxWm9zNXdEeGQvcTZSd0szamNzM2JkRjR5VDIv?=
 =?utf-8?B?YnVBTkcwSnh3eEZtTTcwVENBKzBMUHJpRVpXSFpoSmcyeFV1M3R5QTVDWk9N?=
 =?utf-8?B?cFVwb2E5VFRZaTdDUkxjSzVmV1lWQ0FtQzF6NlgweE8rTVIxUk8yVUJpbnE3?=
 =?utf-8?B?UFFVb2g1UFVrTXlPcnV3ZTM1RW0wb0VFUVVDU3hTRUIxTnY3WC8xUFo4WE10?=
 =?utf-8?B?c0RoTEs4YVlFbzJ5UGhXcC80TUJHdHdDVytjNk1mTjJhN2JKV3kvR29iUlJ1?=
 =?utf-8?B?b2dDOEx3VU0wcldjM1dTYVROeDFRZFJJVk56WTZxeHd2bDlMMVFYSTlRSWsy?=
 =?utf-8?B?MkdDUlZ6THYzWURMOXpYbFo1dUh2Vi9LSzF4eEVjZmluR3ptUHhhVS9XYU53?=
 =?utf-8?B?Z2dheTAxWUZQdElwY0pBMUJ5YVpPUUNuNlhWbE9HaWNsN0NNR1QvTk5UZWJV?=
 =?utf-8?B?c28vM0tqTmpIdDA3MnhkbDB2Y3Bsc01od1VWQlJZalNYdHlVSlRmQXM1eFh1?=
 =?utf-8?B?TkNLWnM0TXg4RWZyQXhvYUdZc1h5MTNZdmNpM2czNTZGN0Nxemx1a1FUNW1u?=
 =?utf-8?B?dy9zUjc5VWxmeXhjS0dDTjQvUUVvS2ppcmltZjc5Tk10SEV6OXJVeDEzaGZ0?=
 =?utf-8?B?ZzZhdWhJOVlCb2M4QVA1UlZBL08yWGwvT2xXOGRIelYrMUVMdGlVcExQL2JZ?=
 =?utf-8?B?bmxZLy9kZ2VhWHcvckFJc1ZHY2d4SHBJNVdRUTdCVFFVcmJLV1kzVUJqUURz?=
 =?utf-8?B?eTIvVGRhUCszdC9jSmwvQ0VlakFRU1JaZlRWY2lmbkJjV0RrbnE3L1RTeWNB?=
 =?utf-8?B?Q0d6cVJtUkpYUTViTWFkRnVLaGdqUXlibFp5LzZURnk3YXh0RURrelpFVDdx?=
 =?utf-8?B?UW1rcFIxOU1XeGlrZmF0YnNIT2lpRTZuMDNtTUc1TS9yS3BiUUV3WG5VY3pN?=
 =?utf-8?B?NDd4bHVGcDBVUHUyc3N2b2pnY01ubWdObkZHbVJiUmkvQUZjVlcwVUZZbzZM?=
 =?utf-8?B?VjBJakVFdXdKWGN0aFllSVVhOFZCTHkrTEdKYWNIay9SSXJiMHlTVlBuSjlh?=
 =?utf-8?B?clQxKzhMNEJsVFZlaDZhZGtMQkh5TjFzb2FrQjdWUk5LNTJTUk5MM2E1T2pJ?=
 =?utf-8?B?endZVzdHWFM0WjRHcnBTTDVwSkQvbWNybmtTeW0va1NwMGswSW13S2RGYysr?=
 =?utf-8?B?SkVEelh2VWM5THhFMkI4VXpsOEIxZURXUUdIM0xBTFNVS2lRTG5KQVJuNVZq?=
 =?utf-8?B?VlVJb2E2R01VVEk3MEdvaW5RcjNhb0MwN0NObW8xRDUveDR1d2FVMnRhbDNO?=
 =?utf-8?B?VDMvZHkwWjNDdHRMb3Y0KzlZaUdqbHZIQ285TTVFcFIzdzUydml5QWtVNXJy?=
 =?utf-8?B?enBzRlczM2V3bjJxRlBFZW5CY0Y3Y0Y5WkpNYmhqYVdMYlVEWWRrbTNMVzJo?=
 =?utf-8?B?VDFhT2dja0tvS0ZkTExRaWZjdms3ZU5XSVZ0Zml3dVQveWFITDNueVdvU2tx?=
 =?utf-8?B?cmsySkh1bWVZSGxxUjd6ejc4amlkcGVCMkVDL0NTZCtIL2JWZ1JublBVWjcw?=
 =?utf-8?B?QjVuM2gzL2ZZZFBWUDJlV3RUU29pMEQvdGF3T28vRk9BaktDRDdDUzRHWEQ1?=
 =?utf-8?B?amF0aUZvb1IyRjNmeW45N00xdGpsYitwTy9GcDFNQm01YklRbW9FSWxlYWc2?=
 =?utf-8?B?Tmg5RTc0ZmVkUUYxZ0d5SnpYNERkSnVpSUltckVDZC9lTm1xSnlQYlptSlBB?=
 =?utf-8?Q?oCuQBfJomgdTbDDnFN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3633a080-5fc9-4651-ddf8-08de73268d1f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 21:57:35.1075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2cgOLp3q3GAJtX00sfQWCB80DwZA3izTsiNBF/N1EPzX+fdL2a3snQUbRK7HkEb4hvnPDRbV9OnuL49adq3rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10117


On Tue, 23 Sep 2025 16:37:31 +0200, Dario Binacchi wrote:
> The series allows setting the glitch threshold for the detected signal
> from a DTS property instead of a hardcoded value.
> In addition, I applied a patch that replaces opencoded masking and
> shifting, with BIT(), GENMASK(), FIELD_GET() and FIELD_PREP() macros.
> 
> I didn’t remove patches:
>  - 2/6 Input: imx6ul_tsc - use BIT, FIELD_{GET,PREP} and GENMASK macros
>  - 1/6 Input: imx6ul_tsc - fix typo in register name
> even though they were accepted, to avoid generating conflicts detected
> by the kernel test robot.
> 
> [...]

Applied, thanks!

[5/6] ARM: dts: imx6ull-engicam-microgea-bmm: set touchscreen glitch threshold
      commit: a96f415ab504484f10673be0d0d9c0e502ca9290

Best regards,
--
Frank Li <Frank.Li@nxp.com>
