Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.42.203.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567805;
	b=oanJls0Akj3Osd0lToImTsVPjcS7hUms9zxmJl28XzqILFDTnTBG8HEsjHmb9UKWuWHg
	 Td5TNNbV6GA68r0cSv3DBhki5NQH6y+8qzeMjI4VM9kVyqjB6Dx1KGKuqzlzjQbrlqeAX
	 EyNhWAic6J7h4KUzmP1kx4gcvPm3AuN6nXXIdnYA93CmOjL0IRCPdCXWfTiTZyG2WXzFk
	 k9boCXNaqYHoNbey6oRFzYWoBaVk5ME1r21NvjEdDgHbDGkZH4zWOpr89a83fhc4Qq2xV
	 uoe7vsk7YXUZtyX8TzTbrPocM3T2opsYM841aOVM8zW14LIGsFrgwe21A3c/oGOqqag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567805;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=IfMDB5jT1COQwB7EaC+iwOi7A/4j/kO76zTU8Es9W8g=;
	b=WuNzaSJJmrIsooYXjhUXP1c8H1FbzH9aKwpUOgWHN0oyUthgqGOoSz1C792kHRNE0yah
	 +M00HuB0sIvdlqgpfUuBbLUWhecbMN4buZQ+A0nwpwAeLMcTsUg0gcnjyYD9qY3KRnrrq
	 1ONvqcTPFRDd/M+L8RFVbiPCjMaJkDqv5InCdkf9EgXU64Hdk0jQm4Xq7kNJOkzxI7UpG
	 ywQYOOpY5tWgHedXS6FiW02vwbdXPVmKc3SWoU0yblXMJObG3ypD/b7I7JeufYYsArpYz
	 S7CyMmekVLE+T8Zyvpm6z+7L1RBjMKsCKiejGE8QyzYxmesQgSzPNxEsL4NirYMQLOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=lvmUcpjE;
	arc=none smtp.remote-ip=52.42.203.116
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83668606A331;
	Fri, 13 Nov 2026 11:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83668606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=lvmUcpjE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794567805; x=1826103805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IfMDB5jT1COQwB7EaC+iwOi7A/4j/kO76zTU8Es9W8g=;
  b=lvmUcpjEzJlppHb1fGrSe6vx6PvOqn6YlzXX+t3MZFWUQoTsQ5UAn8tD
   Ck329CfBbCryLn2lyDMa6bwR0khU15wrYujjxfyAQcqgleNzFQYs2Ejhu
   OGTPjakD3YjYsb42xOJ1lxQjJFt+0Ng21jYrgrCNgNMUpB1lwh0Qm8LcX
   N5mKB8fr9bNxO8iRlid6cPoOLTgtTb5gjLh3Yp3NOzI36njDeuJj0LeZK
   ec1SEMqP66nTxjbkDCEImNdY/UvlCCO7SOtIL3NUzucD8Ns8rOWx0A9oH
   zZQfjmNtgv8OD5szHlfsC7CpT2FXtc6Q4RDBh1LaZPn7ab/VdgO5l6cm2
   A==;
X-CSE-ConnectionGUID: wc8Sr9MET0GF1ptZHaPoFg==
X-CSE-MsgGUID: RrTJuRR+R/++b5y85wG1Gw==
X-IronPort-AV: E=Sophos;i="6.27,211,1787011200"; 
   d="scan'208";a="33912430"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 11:03:23 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:22474]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.227:2525] with esmtp (Farcaster)
 id a839e1dc-e47b-4102-9419-ebbca99491bb; Fri, 13 Nov 2026 11:03:22 +0000 (UTC)
X-Farcaster-Flow-ID: a839e1dc-e47b-4102-9419-ebbca99491bb
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 13 Nov 2026 11:03:22 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Fri, 13 Nov 2026
 11:03:19 +0000
From: Eliav Farber <farbere@amazon.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Armin Wolf
	<W_Armin@gmx.de>, Sebastian Reichel <sre@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-input@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Eliav Farber
	<farbere@amazon.com>
Subject: Re: [PATCH v6 0/7] notifier: convert remaining drivers to device-managed registration
Date: Fri, 13 Nov 2026 11:03:15 +0000
Message-ID: <20261113110315.20412-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113104218.32566-1-farbere@amazon.com>
References: <20261113104218.32566-1-farbere@amazon.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Patches 5/7, 6/7 and 7/7 are not in this thread. My mail server refused the
second half of the series with a submission rate limit, and the resend went
out as a separate thread:

  5/7 https://lore.kernel.org/all/20261113104459.35839-1-farbere@amazon.com/
  6/7 https://lore.kernel.org/all/20261113104459.35839-2-farbere@amazon.com/
  7/7 https://lore.kernel.org/all/20261113104459.35839-3-farbere@amazon.com/

All seven patches were delivered, so I am not resending them. Sorry for the
split thread.

--
Thanks, Eliav
