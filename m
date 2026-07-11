Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7626ACC
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 22:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783809470; cv=none; b=nAzhMc0pLffCNjF+DieJ3lfWfDODoS+NDETVczvWVk6XkvgXMZh48RcVYMdUyQBwEbsmh9I3E02IYZhiTBAEEI3VvIUCylkWkjXc6S6/HZfP/Ip+wltl/4riuOgPfxH57y/N8iwEWOSX9ZrNkG5VBbLqVXbvIHB1XZ1oDQSOSuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783809470; c=relaxed/simple;
	bh=t+wMAo6nkZ+hKH+x6jg2KKlzqWvjToH5nOq8tsbryBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fCAWl3/hnNIPh2wNiwDI5UCrH1DFC8iC+mGHxPuBnoBDtwMgswbrzKSo2sMPERpbJERhC2nH1CU9RepLf5riFldp/2omYSEQxTj5QwF5FYSWzFBXZCTIuOFj054bUzOihfZUbDpId2/dUkCYXd24ActViRL60V5J+PTwOJ15o2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2JlXlPs; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2JlXlPs"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-37df72c9984so3524567a91.3
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 15:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783809468; x=1784414268; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EzS3N/+n2zXhNNX2gV35AYu5hdYKkTXjnhS++PniemA=;
        b=i2JlXlPsV75FdLANc9o/VR6OdI1NevY5DCGUBSdvaTOJZGtivLFQ8m6WUo9cjNt9WT
         1Z4lLsQRkkG9kyp5zglKjg8XFC3jC7UPLSGasrxLoIXvDPtux9Tmjfb+qWUkh+ZqRkxE
         o+Maw+eN0uCbpdgPjSZXCfHjRCvH4fSgAG/E+pJGQADCgrtG/9cLcb1IQ8opLf+VyTi2
         FRntWP35F+llSPFPHFNI3KWwxQKSqorao0ha9gQ+VPaTXKNU0s8MTLZIpMzUK1wzlHub
         x7cvJWWFOWv9nWwkobn78/4WBVdvxuOPKTy/PR/WfsLygSbdeY9L4ZBTGQN+QZpw/4vR
         3crA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783809468; x=1784414268;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EzS3N/+n2zXhNNX2gV35AYu5hdYKkTXjnhS++PniemA=;
        b=HfQsc/XEoBXPE/c5EdpWbqZCXJ0rwWJUxSe/MdwkCG1Nza5367GdtsDF/+u3quUN6J
         Km7I0HoCODxte81d6Cr/l0v9c5YzPN8YZ40Km4WiE1t9Vsyn/xdLp4ynRGo47lKWLEke
         z0Rpj1Fyo5Dx0olEqS5Jo1eEKEmOkqKMZK6X6fU6M4jsU44WVT4BKx0wsQFy17tkmRJ2
         kYUdL4JCdTDH/8hQ8fzSdfwEvHMjwotJgc4AOQ+9nmbqfm9w0D8Uw21lpR9fPt4BphE+
         nDJclR8FBBB6G45LvfMW9QqisjwUXX3Oh/LH0FWlF6X+hx74/FNm1SZI0Ay11jwowxAV
         lzRA==
X-Forwarded-Encrypted: i=1; AHgh+RpSELKOoAo3sDFbMslaimXvVUCBL3OIcATFPL4npwnT59/IamwX/ioDcshSYHN/sxox8VhW4LV33hDoVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdY8+5XpYZpayzX3/GizDKCTa5z+15GA57wLB0IooyTYRj8il9
	FAOmPJAqehgQp0lPrC82mxhedcRzEcVYq8YcNGKMrZMX0lS60mxEN4p6gwM9ow==
X-Gm-Gg: AfdE7cmqLob54bD6gWP/20H10maTuiJW2ZVCeaAHaaE2uz+t6wiuSi4Dl8GkjNoz5Do
	HMOgJHMAVen8YgK2AM/JkqV0NuRKUP8Cy/XoFnYjlQCCvs4lQkXmuIxjsXUYPbDoxzyKe9Pb4Ot
	QSpKHBbxzkvni0wr+XQ44eQTEKe6I6CW1QJbCVQuvgHjaLm49VzlqabzUdX+V4NYzMe8uKfPffk
	RJhvQ0zzPR5oXSFBdcvKgSJ0KgElrvLU21AIeoPguzcYH2ugXtvSgDW+qDCGG8BrTKWO+6HA0HA
	S9gmriKf2Iq24ZQbqa4cFvRHU11qHUGuJikLjRGt1EDp0MG4Cevw8DnsPW1YRtidZq2R94onhf7
	gs+JG7rZbLb9Osmmdksj5kCs+OBE5Ve9T1zI5NUt/fefvDY2yocLUlSqz29zj8KlFTdZKwb/ci3
	NM5NNDYOpoQrpa4PLfR6z/qLPWADhSbsBlIBOXiC608x8GBbVzdEKs
X-Received: by 2002:a17:90b:1345:b0:380:9d0d:7ade with SMTP id 98e67ed59e1d1-38dc7297057mr4249868a91.0.1783809468147;
        Sat, 11 Jul 2026 15:37:48 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:c63e:9756:a95c:c75])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f7293sm53024437eec.3.2026.07.11.15.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 15:37:47 -0700 (PDT)
Date: Sat, 11 Jul 2026 15:37:44 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v7.2-rc2
Message-ID: <alLFtWOLPlPPPQEn@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.2-rc2

to receive updates for the input subsystem. You will get:

- A fix for MELFAS MMS114 touchscreen driver to reject invalid touch IDs
  and avoid multi-touch slot corruption

- A fix for a crash in Sega Dreamcast (Maple) mouse driver when opening
  the device, caused by missing driver data

- Fixes for Maple drivers (keyboard, mouse, joystick) to properly order
  setting driver data and device registration to avoid races.

Changelog:
---------

Dmitry Torokhov (4):
      Input: maplemouse - set driver data before registering input device
      Input: maplecontrol - set driver data before registering input device
      Input: maple_keyb - set driver data before registering input device
      Input: mms114 - fix multi-touch slot corruption

Florian Fuchs (1):
      Input: maplemouse - fix NULL pointer dereference in open()

Diffstat:
--------

 drivers/input/joystick/maplecontrol.c | 3 ++-
 drivers/input/keyboard/maple_keyb.c   | 4 ++--
 drivers/input/mouse/maplemouse.c      | 9 ++++++---
 drivers/input/touchscreen/mms114.c    | 2 +-
 4 files changed, 11 insertions(+), 7 deletions(-)

Thanks.


-- 
Dmitry
