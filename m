Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9129D23BD06
	for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 04:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786767959; cv=none; b=cTYxyuoznrsL1TtnGRoP5H5Avi2o/7sswrmo6yVWNO0LBnk0AuxHMn4PsF8Dz93UUJLJOq1Zg+zo28JxJPmhFGgnnvOSOZGFTJeJ7CoY/IHDbqZ+FCpYFlbMGv15aQYVZgPXcwSfhoL0rZMbEvdOCAGkHULvbte4rCVZ944PlUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786767959; c=relaxed/simple;
	bh=sW0nKLx+tqPZBnX02Hzi5GEhy5DbWLRX6SyGQr1cvbM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W+02eMIIKQN+0q+xVcYwvu+xhqwwLpmtLEc1ONix0yUAzj+E9xPH6r6EsFUAJuCHN/GoaNZjLmJUsI97YmK1dx/QrD8/WRl3/E5kknzK1w/5Lku3zyNTHnRlARC/ln1QCAW7kQWsRRR66HyOeVKZ0NLVFPugOHiQwMl6Aionx50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRrHkHlI; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRrHkHlI"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso1043319a12.2
        for <linux-input@vger.kernel.org>; Fri, 14 Aug 2026 21:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786767958; x=1787372758; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XsAzMDC0HxMmFNm7FmXIqdj6dhMWvO6zZpEY0JxYE1I=;
        b=iRrHkHlIO/Uv+ciCRRS+V7LOKusMv+nY9RnicFSVz4wybho6PNi3xVAiAp9TtSjxkm
         NsGCJm6ZCJYojBbqIKYBWrOieDa+hBAvGG+sGTznhYnKANrBy1GiuMqB8+vhwLkwvZhJ
         NxlanybCPf7VHs0UkmGEf3efPgpOzlToCiysMvIfM5Ka3Y/FpmsPZzVSaKo7l4a1306V
         yOwW8jFm5WlNyc6duRhXXfcH5LhwBO5OHEn03vnXfqCDESTVFch6Lk5kA8LBhn7OZ0Zh
         iGvxeIAgI7DqIeqMXimMx1kp/S+g0u8MlQQ0/Jzy4J7aWBs9h86nbQYXNSDxYEpSDjdk
         p65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786767958; x=1787372758;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XsAzMDC0HxMmFNm7FmXIqdj6dhMWvO6zZpEY0JxYE1I=;
        b=IoJagv98dCYq2EVfg8kTKoiThbzdjGmEDru7oomn0u7+mYu8Zm79aWRzFMyP6xEPob
         zII0NJaGRLZbXPxlPj2EvOdeAyfEqZ9xgTUZYq9K8FrHOPPvv20Z1PW5cGubvQreGrzY
         UKzWDjZ1ZkT80Lsyc2jBPUl3EqzrwLCQTWkSuVRUKo15DWSHxa6D0GzY1lRiuj3BytvM
         3eGlFoPVTuFPJaG2POvBOBTlJY4WluPix+faqZ7iEq+BajsXgxMYe/8f30zkbxhPfLgx
         wMzVApGYASD0LeCrS0WNN+81KcTqrJ2tGE497t2xFOX56dDcSNmQomXCb4naZJesWLsn
         Ka7g==
X-Forwarded-Encrypted: i=1; AHgh+RrGHFJVFTzGa0QWRPse1P1S17tBsoaF3a4Ct10SnUDuCva4zR6yowx4neS3Mi7qbkw28tfA8DyrYk0PuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc1GK/3BtM1hunCWVlz/q2uH11XU1LB1aFvpAZk6ZdQ40Uh2yJ
	b7B/pyMzv7GhSVLDsaiQR+CrGSyjpLPxWYpmxr6hX572YenO3OnJW2A7GUN00Q==
X-Gm-Gg: AR+sD10i1QRqxEIqSUmJnc02L+kb1XTRh6uwsolOVdq/bdnFwDq1YkrptekkgX09E4U
	BcUXqwAT+OyvovZANje66tSCAEGIgemiyUQMaLI9aeDEV+kL9PFLwhR5UANZS0zfUt+sXIBXmbz
	hrnzeSo+fGSDTtHgjm2RQj4eK2ZNE0vTbDBYEEMnU4BfI3xO7lzNJ4myg4tAHIlQZXjMST2/t0H
	o2Jd2NzOeaTdfFZxFAWgnNGCHvqMGfy9OSyitg5b0sSq49w/hcMHQH+kj6vQO6D8Ctuwy2ijPd7
	IuBtZlqNYMf201zDDf/uGLLeA79ocoUGMrpVf4t3PgqZM8JLtwq5cBGQ1hbZ47nOFQax/ySsXB8
	VyXyy568vn65DLk8Lpas3EMGpcYPU1kPUcNqgPIPhSoOLLuXya/DNwSK8HcxBjK1fsDPwc1WMEU
	lWMyacK4V/OQDFuTblCtTWJpX0l8/FHE/GULB4lvYB8KM0672mUv5/gPJNCwi31DgbYTqSMdrLn
	I8ZXmj6P45UcK8Gls87xhEhgKzI7w==
X-Received: by 2002:a05:6a21:e8c:b0:3c6:3c5b:f2e1 with SMTP id adf61e73a8af0-3cc71d8de4dmr12228753637.32.1786767957642;
        Fri, 14 Aug 2026 21:25:57 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e0b1:a24a:3d2a:2ee9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413889d914sm15328044c88.13.2026.08.14.21.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 21:25:56 -0700 (PDT)
Date: Fri, 14 Aug 2026 21:25:54 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v7.2-rc7
Message-ID: <an_qS8vOe05Vhcaa@google.com>
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

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.2-rc7

to receive updates for the input subsystem. You will get:

- A couple of fixes to the sur40 touchscreen driver to correct
  registration and teardown ordering, and to fix error path unwinding
  when video device registration fails.

Changelog:
---------

Dmitry Torokhov (2):
      Input: sur40 - fix input device registration ordering
      Input: sur40 - fix V4L error path cleanup

Diffstat:
--------

 drivers/input/touchscreen/sur40.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

Thanks.


-- 
Dmitry
