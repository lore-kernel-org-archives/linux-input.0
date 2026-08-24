Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64DB38D40B
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602422; cv=none; b=hb7+Zuap3Uk21riyy7/9xwedAPclx1aKsflZamlMtFVujudL0qT7RdEK7ii4ee5iwLTiaEeA9FEv2d2nCmNkV9UGXkWbidSbUYRcInSt52T26BYzZVeP1qQnJ57hnYNN+hHNM/jvyOV8Xp4hIvkTSFv5nDmrKrvmBwXv0XoEfic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602422; c=relaxed/simple;
	bh=ZQ+RojUE9Abzm5WW0MAEQF+3be/n/8dUAUHXvOVL+tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvAkJbJI18+pxQkSTEZaLUPjiG/vev3F8GZ94LYTUPtiAVj+/5TddaHGir8lUgYMSZnFVqRXpaWY/uMbwF0/AFLeAul3ylqPDq+CZjFJjmpQrGibZIQ37OWdxGWoz965You1eMVdHAj/StjRi4zRQwXqCW2dE51haaSpVABS19s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/AtGW31; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/AtGW31"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b0117dda13so3758790e87.0
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 13:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787602419; x=1788207219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gwhgPmF85yfiYARA5MOlhptrJ5ijrLoS8y7nOa4/Mzs=;
        b=b/AtGW31zbBycT2983uJeSNoKIyVPq2kDqrsFrmABODPxC5Tj3cZcU5ZvsZiTrxdmE
         1ZIJzFl6Bbk2uUvoNKVwzx/AJYTHRJntJa84krossxIzUzdwEQ910f0VqRTwEHVP3sa/
         3cX6J8XPl1hOo5buAP6GKvrUrMUndnLDyueOdrbtId84+dnknfAKHODno4cK7g07j7yS
         ONnQNAXUz9ZEDO7riC/VuNH7o0YYsu91nq67/OiOKxSxxW2q+UKRVeXrz8n4zr8k19H2
         dV2Fbai9Yw6D9iviDsDnDxF/Yt9cGpez0PHOIdBibh6ZAt/ReO6vfSPsQv+mk4z3QqeP
         4UDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787602419; x=1788207219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gwhgPmF85yfiYARA5MOlhptrJ5ijrLoS8y7nOa4/Mzs=;
        b=dy+NKQ7UgtLN1CWN9tijvmqTTqLYUD+ZFhYAhhg8rd3Lj16OK75U3ZkFvoKektipF3
         RNtJ74Q7SsZCJ+tg6fRSQsie8y/m9hS59XYcWcUH/Fgh/WUeGr4CEu4FZGsrm3Nlq+gH
         G1pUvz1xQECjvW/TRxsVCrCZofRIm8hVcrf+NwscPCsESjlgHIEoqK10+5hP3O6a7Vwi
         KubDCOMU8K3SLya81CONrEImjdZohfBG37eoKREtLxa/WnFnPzLVlEOanzG4Lk2wNr4j
         aQFoo2jVqX2J/3U2xKHLokSO9fk76jYZkLBJete9A1TCLWCwCyt+9/9c04v5j0xc/yLQ
         Aoog==
X-Forwarded-Encrypted: i=1; AHgh+RrNKjmlTyWxnWuZpcMiXXcPyYiWejAxGwOLQghG4v/O2NuH7owGQ3ksnj4HYYOUWgE70HWBV69fZIDXqw==@vger.kernel.org
X-Gm-Message-State: AFuF++lYsL3WSPqcVmDH7iJEEvjRKkOc07nQTyhVdB89/UF+Dh96XMN3
	ktOFXyPuBqtXBECRQP8teKd0+C/5mP31ZXp7kFp6ayKO0CgXM4i9g5Xw37AlkCogUgw6pwZw
X-Gm-Gg: AR+sD12dfLdws0uxtdJUF5/c/Uu6mxJ2EDxpH0wA3riahUVJjyuvo2Zo5povDwAFuJh
	JpMUYhT0QpVK30X+zsU8SlL9HSd2720YzAyTi8xTw3rJJfTcXwe2Nu5NBGtpASbPVnmyC5wRLo8
	22Y9/csEC2UkqjuN5XiodJ98+hhe56kBr2fabiGisNQQPV+jnUD9KCC3GMaVgItMJattLE01v2q
	dSVXT4NDpof5BhC5rsX3Gi8VeApqC/CVkUo5PYx1i73IM6oz6fXKyR4hr2Lfy96O8pVQmcT+Iwz
	eyD2tZ/Zv6zUrj032kYDuzuumaAtsbuOESVKEWzuiceUSIivSwfJprXXjfmhvLJJD8T4GlZLZ+q
	I/rcv62amvuPLo+xXQvSLJ/Wg2rTaSgZpronD4Zd3uikyLpP/xr2ktBaYI+36UH6BieNTvN9UjI
	M73Xgx9EAb24LcZLSDT/x6gMPPvBBXMokwz7/kG889ULAhInc9afJTQRrW8kiqUH93XktaPxUIM
	xI/U+xziw8MXPDC2P41dsWdacMEoVdxBAdF/E3lRLaFtNegeeMZFiQ1bPzB
X-Received: by 2002:a05:6512:2308:b0:5b0:17e7:67cb with SMTP id 2adb3069b0e04-5b49cdbd7ddmr324772e87.17.1787602418163;
        Mon, 24 Aug 2026 13:13:38 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b48cdfbddasm1942355e87.51.2026.08.24.13.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:13:36 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v5 0/2] ALSA: usb-audio: the Topping M62's vendor controls
Date: Tue, 25 Aug 2026 01:13:29 +0500
Message-ID: <20260824201331.304705-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823222946.171345-1-mikhail.v.gavrilov@gmail.com>
References: <20260823222946.171345-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v5 takes three more points from the automated review, all in 1/2, and
declines two that are a repeat of v3's.

Taken:

  - Allocation on the resume path now asks for no I/O. topping_send()
    is reached from topping_resume(), where reclaim can wait on a block
    device that has not woken yet, and the URB submitted there wanted
    the same treatment. This is what snd_usb_mixer_activate() does a
    few hundred lines away in mixer.c, so it is the file's own habit
    rather than a novelty.

  - A resubmit that fails with -EPERM is no longer reported. That is a
    URB usb_kill_urb() has already refused, which is the ordinary sound
    of an unplug rather than a fault. The line has been wrong since v1;
    nobody noticed until now.

Declined, with the same reasoning the v4 cover letter gave, since the
finding came back unchanged: a control callback cannot dereference a
freed private structure during disconnect. snd_ctl_elem_read() and
snd_ctl_elem_write() take snd_power_ref_and_wait(card) around the
callback; snd_card_disconnect() ends with snd_power_sync_ref(card),
which waits until every such reference is dropped; and in usb-audio's
disconnect, snd_card_disconnect() runs before
usb_audio_disconnect_components() reaches snd_usb_mixer_disconnect()
and hence this driver's private_free(). No callback can be inside the
driver when the structure is freed, and none can enter afterwards --
snd_power_ref_and_wait() sees card->shutdown and returns -ENODEV.

Nothing else changed since v4. 2/2 is unchanged. The questions from the
v2 cover letter still stand: whether snd-usb-audio registering the
hid_driver itself would be a better shape than either road posted, and
whether there is a convention for a control that can be written but not
read.

Tested on the hardware as before, including a suspend and resume cycle
and unbind and bind again, on a KASAN and lockdep kernel; no reports.

Mikhail Gavrilov (2):
  ALSA: usb-audio: expose the Topping M62's analogue gains as mixer
    controls
  ALSA: usb-audio: let the M62's outputs say what they listen to

 MAINTAINERS               |   6 +
 drivers/hid/hid-ids.h     |   3 +
 drivers/hid/hid-quirks.c  |   2 +
 sound/usb/Makefile        |   1 +
 sound/usb/card.c          |  19 +
 sound/usb/mixer_quirks.c  |   5 +
 sound/usb/mixer_topping.c | 744 ++++++++++++++++++++++++++++++++++++++
 sound/usb/mixer_topping.h |   7 +
 sound/usb/usbaudio.h      |   4 +
 9 files changed, 791 insertions(+)
 create mode 100644 sound/usb/mixer_topping.c
 create mode 100644 sound/usb/mixer_topping.h


base-commit: 2709dd5ae32f0828f386327c76bba9f39f63a1c6
-- 
2.55.0

