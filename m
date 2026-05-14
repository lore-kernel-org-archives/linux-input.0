Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC33C31AA87;
	Thu, 14 May 2026 01:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778722570; cv=pass; b=NNHdDpu6zM5wFt8Es2/p5nz1L8N6Am6A6Og9M8mdL+EHYpALQeN5UXEItXulEuGUlp2vFUINxufjUO5I7s5fiWkS+Bpb1mJ0LHBs//z8Mfoc2KxRA1iZZXFskLTgymhLEF9N3g8Nocs0LF1KNPQ3xLNTQcqLvlYNWmgJdKSBGHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778722570; c=relaxed/simple;
	bh=RWqhE1hSqheSEXoi1LbUbXqRVoURfh72r/3E+KppjO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQ2LfsvRFmoIPeWWj8I7nuJmhbbb/+Ln8jsw/pr+ttvg+zjemA9KuSzi3Is5y58uEwbn39DSmXqDsFFEitJz1TDXKix12HFe1kwFrQobwGjI1YisnvaStqlmPosbsNTzaoqWR4EJLhqgaKai4lg4Qm1GHaCbpknPmYj2vJZTdsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bazaes.cl; spf=pass smtp.mailfrom=bazaes.cl; dkim=pass (1024-bit key) header.d=bazaes.cl header.i=contacto@bazaes.cl header.b=EAoFBgbD; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bazaes.cl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bazaes.cl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bazaes.cl header.i=contacto@bazaes.cl header.b="EAoFBgbD"
ARC-Seal: i=1; a=rsa-sha256; t=1778722566; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TZ+oCa1B5B3SNPEwiD8z3lc1Qv0xIg6cZBA69S1LLc1FigROu3MXNwFBMgWVXC26P/kOqNZrxxy6zDXVIYe/mcippaiB5WDzPNp88XBY0rdnWnoA4i7vsgeRpuq97eYpx+auiSBOHY1NVm+0kDVVlkrnQjle1ZxJEc7GB9C9Wwg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778722566; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+nmHcnlybrGuEe7UvVyYC1CXsO/6l0xtUXHPCz70nGw=; 
	b=EXmkeVK4Z5JOTOaKDTOsMj7E9jRwXriZrQsh6rmr6OmXivQiUX/5O/6pECVoqGXH7RZVVyZeVqINxP9giZCKEmRPT4OEgGTAUOV8nwsKZWDICLJxmZ9WIF6SfegzcHcG2flLeW5G9yaM/IkpFwJIGaMCLBMSe1QpUx3cJcG/dNc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=bazaes.cl;
	spf=pass  smtp.mailfrom=contacto@bazaes.cl;
	dmarc=pass header.from=<contacto@bazaes.cl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778722566;
	s=zmail; d=bazaes.cl; i=contacto@bazaes.cl;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+nmHcnlybrGuEe7UvVyYC1CXsO/6l0xtUXHPCz70nGw=;
	b=EAoFBgbDvtvxYFuYbqNFlPeumCNAm8OZLEGHnh7oa58rqHtdJiOv9hAk7uKWEvVy
	a29TGppOD0+GSKbG86zvm5uQlMB6NhGr2qj4yK1Jixbe73MSCU6zdpiKOpLHFtNhAaX
	UL4qkPyPwnYXigYgq5nyP7qBe4xZGgT+HXP+12Ew=
Received: by mx.zohomail.com with SMTPS id 1778722563244326.84577487932575;
	Wed, 13 May 2026 18:36:03 -0700 (PDT)
From: contacto@bazaes.cl
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Nicol=C3=A1s=20Bazaes?= <contacto@bazaes.cl>
Subject: [PATCH v2] Input: synaptics - add LEN2058 to SMBus passlist for ThinkPad E490
Date: Wed, 13 May 2026 21:35:49 -0400
Message-ID: <20260514013552.14234-1-contacto@bazaes.cl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <agTso46UcMSGaIYx@google.com>
References: <agTso46UcMSGaIYx@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Nicolás Bazaes <contacto@bazaes.cl>

The Lenovo ThinkPad E490 (PNP ID: LEN2058) has a Synaptics TM3471-020
touchpad that supports SMBus/RMI4 mode but is not listed in
smbus_pnp_ids[]. Without this entry, RMI4 over SMBus is not enabled
by default, and the touchpad falls back to PS/2 mode.

Adding LEN2058 to the passlist enables automatic RMI4 detection without
requiring the psmouse.synaptics_intertouch parameter, and matches
the behavior of similar ThinkPad models already in the list
(E480/LEN2054, E580/LEN2055).

Tested on ThinkPad E490 with kernel 7.0.5-zen1 and Arch Linux.
RMI4 over SMBus is confirmed working without any kernel parameters.

Signed-off-by: Nicolás Bazaes <contacto@bazaes.cl>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 26071128f..c70502e24 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -190,6 +190,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN2044", /* L470  */
 	"LEN2054", /* E480 */
 	"LEN2055", /* E580 */
+	"LEN2058", /* E490 */
 	"LEN2068", /* T14 Gen 1 */
 	"SYN1221", /* TUXEDO InfinityBook Pro 14 v5 */
 	"SYN3003", /* HP EliteBook 850 G1 */
-- 
2.54.0

