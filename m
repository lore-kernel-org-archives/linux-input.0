Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB9C2512C8;
	Mon,  7 Sep 2026 06:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761461; cv=fail; b=PfZIuRrgf5m2z641pBwvRUvsjcLIdXZI9ZmQCUo9byhCbOZBlkwYuChsm7K7EsYxPVPpH23zxFr0VIsHqMcVrMyk/bzc6yNH/MQpbljvDORKfm4uAKGilrCteQyADKlDu2q/U6qMeLn+EPTPNSeS5ckzZh7O8jk3l9z8lNCj9/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761461; c=relaxed/simple;
	bh=ghP37LM/uP+412tuzi4Dl7xqXWdxunAZdbVrWBD2SrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJhzNKDd7lNwH3z3tNOYR0qtuGt3u50IGXoZinVxwoALqo1/Fcn8bZnWi3pb1pxAYBDHqHGJUmFCRcwnVOhXcyqXZdKVjVXKrfj8AN0z3fVnDfNw//6Ahve5DTCbz26OCadzFo9MtCNBpYTlq2j2k9HrbvT5ZoVKjppXJA9CXtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=PCFGUYTD; arc=fail smtp.client-ip=52.101.46.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="PCFGUYTD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlwce6byimiYKA7ws8PylAk3A0W5eO7AuQQ8utKQQwml/NUIqzeU5Czp3i63fP4XYTuDUxEmvRSdD0QpMHxySrnf7DALaAXovo5RtjkhgQFbOGgKLtLbqFVUcqZ2Y8dwRfeiSiAzmkgySJ386KDsRbRj0x0xpBnoJxndcXjl6DJJ7ZF8eoNFx79LjeN9f0LRmrXIVlNe/rsa2uIiZdXUEzfmNoUviLqhjp4iBhBvsUqiyLt/v+PzARVE+p/mw6KHbn1WPuvotESKDajv423DEElbtTo7fjxWoS5krAJtLZaO8ALgGNU/cOxmjJIubC4FtGdE+dpP+Ld3b8XYMP9jyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIGz7hkh1JLUWmN8+M5d948EhmjRlHePmb+QrUM2OXo=;
 b=f+CgPQSUv4fnbomptfT+18uUWdbtIVDCt9KnzmVMLbIWMucjkyhMAdB+mZM40VB4Y+GtPRhRzSEdWo4o/acGzEJvTN4cDpe18Kh7z6/NU/41WYcXUL24m6/Wrvk3Ri5HH1OYXJPqUSJv0zqRLjBiMj+XkY4MrVrCnFx+Eb0rqoLp0jooMlNEkRguQi3wgCrF1VM7EKyrKruIr7MBExr7toL8v6lxxDRkmjnnGkHu2vE0ljdHLyyUCnzWswt0NFwbRbqtMyRBxQqdFBQeBdHGBxDfFgl6zWvAH+ShZtBbn1RTudp3UTTi6s63RaFgXwIvY6Xzdk4vgSWLIvBY1zi+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIGz7hkh1JLUWmN8+M5d948EhmjRlHePmb+QrUM2OXo=;
 b=PCFGUYTD+pdAIUc+ZlrepynhgpGPfq4eEcfPIW5c/U1LLqa70e10Z2YZzkyk+2a5v/Z3D4993OPDaFxKI4Ycri5NB7bvQHEtQPZtRbVODE1ZBf1IbKKpyotB2t7p5vEFm6FCIj24re+8feBHDv5Ch9txI9Vc0gcK+X5i5LHjihAuQxesYkL2TyWpF7exJM+UMasq/9+8hkqTIrfY6uYxEBGPcviibZFgV61GEB4pohlAdnJ7jJFvzphkfVuTncDqFkoR8Ja59ibLogRuZDAc+EPAXqLp5Xft0zhPpVPWShQ+xumQhZt2yDy+eqApiGFlGxYTDnzdu9bsFpSUPenUNw==
Received: from SN7PR04CA0003.namprd04.prod.outlook.com (2603:10b6:806:f2::8)
 by BL1PPF71FD9CFFF.namprd22.prod.outlook.com (2603:10b6:20f:fc04::f31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 06:10:58 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:f2:cafe::4d) by SN7PR04CA0003.outlook.office365.com
 (2603:10b6:806:f2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 06:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 06:10:57 +0000
Received: from zeus (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with SMTP id 25E00E4DB;
	Mon,  7 Sep 2026 09:10:55 +0300 (EEST)
Date: Mon, 7 Sep 2026 09:10:54 +0300
From: Ian Ray <ian.ray@gehealthcare.com>
To: budcomfort <budcomfort@pm.me>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jikos@kernel.org" <jikos@kernel.org>,
	"bentiss@kernel.org" <bentiss@kernel.org>,
	"buingoc67@gmail.com" <buingoc67@gmail.com>
Subject: Re: Dell Latitude 7220: eGalax P80H84 0eef:c003 factory passive
 stylus not detected
Message-ID: <ap5VbrllY_qDf_Y2@zeus>
References: <62t8PiydnEWbOsSM0byy1IRKtFwxg7nfDZUtsgbE_1liuwRpKtyKZYsYwOe52IZ--zdy1QJg11p8u13QajhgH25DexN-Fx71z5TSlcLE6Mw=@pm.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62t8PiydnEWbOsSM0byy1IRKtFwxg7nfDZUtsgbE_1liuwRpKtyKZYsYwOe52IZ--zdy1QJg11p8u13QajhgH25DexN-Fx71z5TSlcLE6Mw=@pm.me>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|BL1PPF71FD9CFFF:EE_
X-MS-Office365-Filtering-Correlation-Id: 7541ac12-c8d4-4a5e-ea0d-08df0ca6c887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ijeH0skEWzmrCG8kNEwP0Pf6Fb7ohXvKkRAtUaD/Ik2Dhb0Dw4BzPWyEyoCmSF1sLXhf1Ie6bd9wHLnCFNXyfOoUNMVo+JaBvohFVFvrclxXjjZmayimpBINLKZt9YXNf6SbsM9Ozv2Ff8T63+ckFUDu+F19wDGKaWq7BGboRyauvg5EXc0wLbyOXWP6vxQP7+9fCawNKHVqM30x4rDAqWQHX0Wl0tD5mK5mGr2C3jrW3fZ567CxRG2WeshnsL7ebqLbq+bTlcUD6TK09EYritUmrB+oUcgJ+d8txUvYocjALFsyoAzozLMpElEadwWT+PUl/wZjXBS8JHvPlSdRblbgxr4oRNer0SyBJN+stAZoax89GcFLSz/ajzzbTp1ZVc68iKwPbcp5dW8g22Yr6y3t8hiJr7Y65gWWGE7ripnYhLz2IRE5qnWn/4plNHMYbuNP+7nnaF9OAG85n/HOp7ovKiHByGvdkI9apRGquMAUKuhU4s/DcdH5G9g3kV3e1lCNmmmNPjmEwqP8pqC4poiINM1uPj9iWIaimO9f5GrIf5x5/kJWUaTdpWXbSIZEGb5NwZhYbUf+gQljm5x+pjkU/WQ8esu8WtvrCXtDHUb0qnLzB+YieJiE5tRGIesZdGkMrdLNS8CZirpgCcxHnrU4cAxCeeuuoTsRMHze33gzRNTO6kSmo3BXU9fDDI5UxdTC2G8nMWDNymnECyHczg==
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:atlrelay1.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XG+SifmIKPn7/V9Ry98QBN655eV/fHTAwJJdjtwtndxoIGmeO9H1BQT+7l/emUbGVNMMdpHm/0IJZFzpVzrWcBLmSJc4cpC0t2Yim+MUoW9+S8WHAU0XKNd2URBCNUhGZX0UDmjKoBAl8NjOJtHx8NoqTa0/SXmQqbONlGQtxoAjWQFEy3oRC1Yq5O5GX9KE9KjOq6orixfrluaeXAKOg9VA0p1b7f4bSGGGPy1YMMFs4DDLZXnmtFmVjn2/480UBLeGcDTlcWnYmYmaKmwStvGuuiX4c7gawRp1pnPEjVn4zD9MxoW/N27HASqk64pAbjAjs6yFIhtmMJr1ymt9VS5H2/Y+odYXj/yCx/62zto+MmAINA2/1hGUpeKbl36tAmtwiCWy4TkytP88HLL3je/IaZLVvidFsdXL4VgcnJKqoqFEorwYeM051uFUd5iF
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 06:10:57.5685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7541ac12-c8d4-4a5e-ea0d-08df0ca6c887
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF71FD9CFFF

On Fri, Sep 04, 2026 at 01:53:54PM +0000, budcomfort wrote:
> Hello,
> 
> I'm trying to determine whether support for the eGalax P80H84 0eef:c003 used in the Dell Latitude 7220 Rugged Extreme is a known issue or is currently being worked on.
> ...

Hello there,

Sorry, this is not something I am working on.

Blue skies,
Ian
