Received: from smtp-out1.simply.com (smtp-out1.simply.com [94.231.106.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ACA3BED46;
	Thu,  7 May 2026 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146157; cv=none; b=q0BHiJbrAAJ9y37UpvT+hQhKLf4Ghns7+Mk7HZREq5zhQBmBkBcGcU/sr8ezk5miOJu9MVVmVMshz60NtN5XnXIUdx1V3JoVEEkFrd1Z/uFXbZFvi6KtgBpVabJHu5vA2Ya8T6UCzYLq+m3KGCPg+Qq+2NNSEqenCcH14nlMu6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146157; c=relaxed/simple;
	bh=o/P9uyz/FiX/1rEFBPKXJP2QS+aKC/+Atb1Cea3uVo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAkCAuyOU4vPf4NbfZVz8uALwWn/benusgBWZyTy8DnJ/sq9HXwyfi0Zk7916vhA6wyHdWUMTIHKA52Jn927AgCB7UIPy4GMPt58yCa4oq/X84M/56ASdPMJySVZF50jyikkk/FHvMS9C+aFSeQND1/FtkhqKYr7ehop0zVcg4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grenangen.se; spf=pass smtp.mailfrom=grenangen.se; dkim=pass (2048-bit key) header.d=grenangen.se header.i=@grenangen.se header.b=Xdj5KCKW; arc=none smtp.client-ip=94.231.106.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grenangen.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grenangen.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grenangen.se header.i=@grenangen.se header.b="Xdj5KCKW"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4gB6QJ1JFYz1DHbw;
	Thu,  7 May 2026 11:29:12 +0200 (CEST)
Received: from localhost (h-217-27-171-125.A498.priv.bahnhof.se [217.27.171.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4gB6QH5Hvzz1DHnf;
	Thu,  7 May 2026 11:29:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grenangen.se;
	s=simplycom2; t=1778146151;
	bh=4kjPjsS6EZMYNCOahr97s6NWtPgrCBkTq+Ez4q6foyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xdj5KCKWXqwo+V0cMlD17oDE5un82n1lXz+49TuLqhUCzYMBM0x4OkSIzKEGLfq47
	 3na8m8ESWEybjR4ZwpQkY7HlkRoov3/PPLH1yxSwAa9hRb2wJS04C/Pyn1jF7BWwbI
	 7qh+3OZlvOPamRzhK/GNNbrPbveRD1EP5ZGn7OmJzZ9QHvXr8tk/PL31VlDaQ3mDE5
	 Tge2J/UWkeUnqlF9Tu+6cUNfi+WfFybw+wM3une0e5N9+K9aR7UyIxx1PtbLEk2Tt4
	 QEcivagt9nFXESLWm08e0VU1AhnOOh/uca9j42Wsa6+1gbE0nu2YAsFDjkcGyGKUS2
	 WWKekPcBqml0A==
From: =?UTF-8?q?Marcus=20Gren=C3=A4ngen?= <marcus@grenangen.se>
To: platform-driver-x86@vger.kernel.org,
	denis.benato@linux.dev
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luke@ljones.dev,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	corentin.chary@gmail.com,
	marcus@grenangen.se
Subject: [PATCH v3 0/3] platform/x86: fix fn-lock on ASUS ProArt P16 (WMI DEVS no-op)
Date: Thu,  7 May 2026 11:29:08 +0200
Message-ID: <20260507092911.8855-1-marcus@grenangen.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <9b568ce0-93f7-4a7f-98e4-625e910f8a1d@linux.dev>
References: <9b568ce0-93f7-4a7f-98e4-625e910f8a1d@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes since v2 (addressing Denis's and Randy's review):

Patch 1 (HID: asus):
 - Renamed asus_hid_fnlock_notify() to asus_hid_fnlock_set() (Denis)
 - Replaced "if (ret > 0) ret = 0" with "if (ret < 0) return ret; return 0;"
   pattern (Denis)
 - Fixed Returns tag format to "Returns:" (Randy)
 - Added #if IS_REACHABLE(CONFIG_HID_ASUS) guard for asus_hid_fnlock_set()
   declaration in asus-wmi.h so asus-wmi.c can call it without a missing
   prototype warning

Patch 2 (asus-nb-wmi):
 - Added asus_wmi_fnlock_use_hid() export so asus-armoury can query the
   quirk flag without reading the quirk struct directly, keeping DMI and
   quirk knowledge inside asus-wmi (Denis)
 - Fixed Returns tag format to "Returns:" (Randy)

Patch 3 (asus-armoury):
 - Replaced the stored fnlock_use_hid flag and dmi_match() call with
   asus_wmi_fnlock_use_hid(), routing the DMI/quirk check through asus-wmi
   as Denis suggested
 - Added fn_lock_registered bool to properly guard sysfs_remove_group in
   both the error unwind path and __exit, mirroring the gpu_mux/mini_led
   pattern (Denis)
 - NOTE/Question: Since we have proper fn+esc hardware key handling working 
   now we could eliminate this patch completely if we don't care about 
   being able to control the fn state from user space 
   eg. asusctl and/or rog control center?
   The nice thing of having it controllable via asusctl is the
   scripting possibilibilities like setting prefered mode when 
   starting a DE as one example.

Regarding the if/else dispatch in fn_lock_current_value_store: Denis
suggested routing everything through a single asus_wmi_fnlock_set()
exported from asus-wmi. This was implemented but had to be reverted: it
introduced a module dependency cycle (hid_asus -> asus_wmi -> hid_asus)
that depmod detects and rejects. asus-armoury therefore retains the
if/else, calling asus_hid_fnlock_set() on HID-path platforms and
armoury_set_devstate() on WMI-path platforms. The asus-armoury -> hid-asus
dependency is a soft one (the stub in asus-wmi.h returns -ENODEV when
CONFIG_HID_ASUS is not reachable). But since I'm new to this maybe I'm 
missing something critical here?

Marcus Grenängen (3):
  HID: asus: export asus_hid_fnlock_set() for direct fn-lock control
  platform/x86: asus-nb-wmi: add fnlock_use_hid quirk and asus_wmi_fnlock_use_hid()
  platform/x86: asus-armoury: add fn_lock firmware attribute

 drivers/hid/hid-asus.c                     | 44 ++++++++++++++++++-
 drivers/platform/x86/asus-armoury.c        | 70 ++++++++++++++++++++++++++++++
 drivers/platform/x86/asus-nb-wmi.c         | 13 ++++++
 drivers/platform/x86/asus-wmi.c            | 22 ++++++++++
 drivers/platform/x86/asus-wmi.h            |  5 +++
 include/linux/platform_data/x86/asus-wmi.h | 15 +++++++
 6 files changed, 168 insertions(+), 1 deletion(-)

-- 
2.54.0
