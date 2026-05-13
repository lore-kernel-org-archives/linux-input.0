Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752503630A4;
	Wed, 13 May 2026 04:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778648289; cv=pass; b=gtGPZwOKrOTr9mQ6Ql1DlaUaUYcFb+HzqUIETiNB/Ty4tEtSVFzxw7CmAQLDlR/KQCJHyFVu694m0r8jMwYIat7RCbl97PcYxsDNjqk+Fbwft4Gmqj5c8Yr3uziLYwkFkH5e/PV/7FNHuZ6etG++PSE8KfC1gH807mANeEAJ0v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778648289; c=relaxed/simple;
	bh=AZCppq48UTory1crM7GL0sfzkSiO4MdZtBNTkxmn1uM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d+cAhoP7Xqx/GKldmD844f3MsVYhPcXjQ/VUwkrjMvv4H7NxvgIiEgOD1MBS9BZ84fFAZTNbCjP1tj0jC55lf3pcgH2jAf5ucZREqXmDX0wmHTV/EGbE+YrtqEwoWtctsU4y84/3NwsMMJRCihVLftXrs+J9FPlAYhMKD5E7a/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bazaes.cl; spf=pass smtp.mailfrom=bazaes.cl; dkim=pass (1024-bit key) header.d=bazaes.cl header.i=contacto@bazaes.cl header.b=QilVpbfb; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bazaes.cl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bazaes.cl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bazaes.cl header.i=contacto@bazaes.cl header.b="QilVpbfb"
ARC-Seal: i=1; a=rsa-sha256; t=1778648285; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ezmNn8m2T2ZHyWTMApPzpuz4CdeFg4PGv1lBFCBK1ueBZlShnwFafkcSZlabssQPIA3GU1Ap/QOvw82v5lzbnSwdbsGOY71e3BSJa+1Ce6t767REQoPnj1AEi+j+50nxQdzo9J1Gjilcg//NMXdSFDWAgqZLy6wu34c15aZMatc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778648285; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=S3hIYjkJI64zk/pzvN7o46XkZCq1j/OoVyJNpVfFn8A=; 
	b=ePGmmCmp3eeLDA5/c8+KPStVd45VCt0djzRe00YatzGmfKW9B5sEzfYXzSnAk155IT2EprLUlJhFM9STR/RIXWNjYFKW0+q2QIAw7jvr/M+jHHQCi9ZXoVAHYw4SdpX4Z2GOoK15MWlImPNKLRlcLbcoszly+cXlzT7j4s8Drq4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=bazaes.cl;
	spf=pass  smtp.mailfrom=contacto@bazaes.cl;
	dmarc=pass header.from=<contacto@bazaes.cl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778648285;
	s=zmail; d=bazaes.cl; i=contacto@bazaes.cl;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=S3hIYjkJI64zk/pzvN7o46XkZCq1j/OoVyJNpVfFn8A=;
	b=QilVpbfbqDGnPnQH9MIDoggRtmSGhYlcKBp2JAQiG40Ym7tcnfgRZVWoFCfqPFJG
	w5CHFxxq9p6/ZpS9UbDo6JPR3GuxbOLpy8S+5Ath9b/d9yZy5oIkGW5Xwe4rJk9En3p
	Jde/9KHM+m5jZqN3oiyAXhJcqOEWSR4Tb31h+mAc=
Received: by mx.zohomail.com with SMTPS id 1778648283150804.8467399824419;
	Tue, 12 May 2026 21:58:03 -0700 (PDT)
From: contacto@bazaes.cl
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Nicol=C3=A1s=20Bazaes?= <contacto@bazaes.cl>
Subject: [PATCH] Input: synaptics - add LEN2058 to SMBus passlist for ThinkPad E490
Date: Wed, 13 May 2026 00:57:44 -0400
Message-ID: <20260513045749.185969-1-contacto@bazaes.cl>
X-Mailer: git-send-email 2.54.0
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
smbus_pnp_ids[]. Without this entry, psmouse ignores the
synaptics_intertouch parameter and falls back to PS/2 mode even when
explicitly requested.

Adding LEN2058 to the passlist enables RMI4 over SMBus, which provides
better multitouch support and matches the behavior of similar ThinkPad
models already in the list (E480/LEN2054, E580/LEN2055).

Tested on ThinkPad E490 with kernel 7.0.5-zen1 and Arch Linux.

Signed-off-by: Nicolás Bazaes <contacto@bazaes.cl>
Assisted-by: Claude <claude.ai>
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

