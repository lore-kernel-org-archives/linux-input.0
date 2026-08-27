Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A442D8376
	for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 23:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787872605; cv=none; b=ZbVlbO4e4Kj6ah9SDj7lbF6P7g4hRMEIVEPG7bPPLi3Bvh1NGU/SFiXdfJLlFIfvsrn14zkYBJYlq5TzmNDvzUOekREYe3BSTxnXJY2jgclcMZX6YX/nKCyLlsyU5fHJStYEcVa4BYvoA8U61J1Vt1Nt1WxmDpL8vd+voVnDLdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787872605; c=relaxed/simple;
	bh=UdT3hGNALeUvnboImYmMvZ5TECkCwAEoQ9XDAhgPc1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MuW8ZtMS2JJLciif0EMgjzaQVSFfWwSG+U0cGqHIFpC2HrmNcyTb+M4G9HWwl0SLpCj65n22BpbSQdNARSofFrNB1hULFt5Pgk9vIDVTghASgz3Eb2ssVH2idXCsWw3W55NLFeI/ioTC3yhRHHzQHkWHPI/WfPQvwSXcBucaL1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpYHT4Iy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpYHT4Iy"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso3521585e9.0
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 16:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787872602; x=1788477402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VPhJkcevED7Y+KnWzw97fILHTL0049NkaJvngpw2zCc=;
        b=hpYHT4IyZnHuCgT7gsmtgEumiHvzIyRATexAxnncZOMfC+kuXdK9WrNqsX1UUegIH0
         hFM34SbWBkvqY62/XTzZWUXABYokysa9nkoVgPdtb5nGTHUPG1wqrddaj/mjNj5JK3sI
         NrP8WKN4nvMByTW4v0mHeEvtJUQY8PFSTX1/3Bq64undtMmPsg93GwJRA+9sbYke4gbi
         ce20f53SZJsR7BgVyoMQoB6sPzugamhUKpFMK+FURoL1ywrj0Y3VXtdqmTOrhZ0kk6qb
         i4xPA04Nfvkk492IaRpyltiK+XdZbrjHBrixuswjRu7pjpgAnLDfUWeOLF1o30PK69P8
         CSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787872602; x=1788477402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VPhJkcevED7Y+KnWzw97fILHTL0049NkaJvngpw2zCc=;
        b=Id/Mqfh+89XAU8G94HvhEVAS1EWCp67aDGzGrCV/eX+SSFF02SEP9BppuzslScaeAg
         zOjpmYnJkxv3TetV9Yn5f2XEHlvBNeWwM/RFq+Xp2dh4D6YuJyfvmRA34tzg1C3t54Vh
         Kg+tgdbUj3ixMY7FBSn9Cwq4neX0XW8cp/MxAER+zXFI1jzZHmO96VeeC6TYZqrhQftA
         P9mPBXoEjBgoFr0KYNmby2oHz2xe5hwc0EjInQEpjNpr36F4rhmhWU0OuXomV0imsGAf
         IBbE5E5JBAlQzbYdTIp7SDS1H2MJFJTtkxz7tf1hCVBJdxJIgvAuQceeI0B7zXupTr0d
         y95w==
X-Gm-Message-State: AFuF++k2WU5ZHQLM//1Y2BEmsz08GQ3ugAbMLgmNbJe9iuJ20nwLPdYV
	bA7/C9vmPSFM3nR+GaYAqaZgiEmwXCeXrYjKpBYtf5MUN70kMvcVDIvG
X-Gm-Gg: AR+sD11IBo40h/Xn+9MR8NC7FIdEVBtDLGsCWGT7IKT4chT48Eaq2PSl7PYxC+QyZdV
	0x7TUxptQTNB5e+urK8HBpsjsa+dW140YaZx4xkOyX1e9FHnFGPKqvSEw2ZnBSMISmB7jrm6Fg6
	TViF5tG84PxGbOmrcWIVm2TUK8BmMLwbY4BKpxSTLM/PUgLK24hVsxz5oCYcCvfT9d1N3Z5Mvrb
	Wr85mu7Px/kEFMVuLCKG8kvRHw1+P3msr12QTRy7OZ1tPeXrsI+88wcZiG05qR6m4/ZVX/nH8sP
	C2WgwSuBAaf6rblnvT+gDFvKX5Ol4P6H9LOfqodMNsHzkGR0768exDvn5tbq9AHad9pmQQIfXY6
	dA3vK1/dATQUWZc6ZBTF00YKA8vZVBFMXauovEio58KNnf/GWvMsj57V7PuggJDk1TNOUffJO1w
	0aI0lijHQBE0YYxqoNqJlyImE1e1FHLqQ4r7TNG0C14VLIxrcejDE3rM0xIsF2PkTy7Slm2oR41
	m99dL7FDllUydewKdvrU38ZgHaAjH5VZ/+XXUGVfMwy
X-Received: by 2002:a05:600c:1d1d:b0:49b:d45:703e with SMTP id 5b1f17b1804b1-49b91c2dfecmr31994195e9.8.1787872601879;
        Thu, 27 Aug 2026 16:16:41 -0700 (PDT)
Received: from 1Z10 ([78.213.170.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9269f1b6sm9835725e9.4.2026.08.27.16.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 16:16:41 -0700 (PDT)
From: Maurizio Casciano <mauriziocasciano7@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maurizio Casciano <mauriziocasciano7@gmail.com>
Subject: [PATCH v2 0/2] Input: drv260x: restore configuration across power loss
Date: Fri, 28 Aug 2026 01:16:35 +0200
Message-ID: <cover.input-v2.1787872237.git.mauriziocasciano7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DRV260x enable GPIO disables the I2C interface and resets volatile
configuration when lowered. Closing the input device or suspending the
system can therefore leave the controller unconfigured when it is used
again.

Restore the actuator configuration when the input device is reopened and
after system resume. Quiesce asynchronous force-feedback work during
suspend, restore a usable state if regulator shutdown fails, and keep the
firmware-selected actuator mode unchanged during playback.

Changes since v1:

- add a separate first patch restoring configuration after input close;
- stop overwriting the configured actuator mode during playback; and
- retain the suspend/resume sequencing fix while restoring all volatile
  configuration after the enable GPIO is asserted.

The previously posted optional-vbat change is withdrawn, as requested by
Dmitry. The Yoga Book enable-GPIO mapping has also been removed from the
generic Input driver and is provided by board software nodes in the
separately posted platform/x86 v2 series.

Both patches pass strict checkpatch, W=1 and sparse v0.6.5-rc1. They were
tested on a Lenovo Yoga Book YB1-X91L with both DRV2604 devices. An
RTC-timed suspend-to-RAM and resume completed without rebooting, and both
force-feedback devices played effects afterwards without drv260x, I2C or
configuration-restore errors.

With Best Regards,
Maurizio Casciano

Maurizio Casciano (2):
  Input: drv260x: Restore configuration after device close
  Input: drv260x: Fix suspend and resume sequencing

 drivers/input/misc/drv260x.c | 58 +++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 10 deletions(-)


base-commit: 9a29ee801f525bcad71fea021bfe2a030885c8df
-- 
2.53.0
