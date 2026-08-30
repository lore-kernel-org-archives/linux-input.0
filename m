Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6839525C818
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788077671; cv=none; b=g34uUSzvThqkmFmDWYFtC02ve7s+PMRR89IhuMOkEoM9tYI8+C8GxFbjmIohENAJPvnUIe1eTq1gRGm5d+cPQaCUAMULdlPrgPR/7lccWDNechdX4jQWD/SnjAQqYvHNHqq/DNiVkhx0slIv30bKKSju64hKGItYv0AeQNw+mMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788077671; c=relaxed/simple;
	bh=qGDPLRSzCRXB3K42SgeFJHX221LQxCp5VEhaudg6mc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdEayisFL/VPg8q5t/OrCY+JsDX+qmyOO+FG7HPuhaTjdw2gpWXgNXuOPdzZYdkp45cuEYn26uXEm14hltIh0Dag8DgEa4mPQgqUeBqmRMd8JYsdUDYuK87F1dbFixwgcbFDYb+q79F0Ys7rqZNRPHjpjKSokntBOzACuXgn5Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aky0evdJ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aky0evdJ"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1c9879395so1857376a12.1
        for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 01:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788077670; x=1788682470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YmBdbxLkPCMqqCoIfbI1P+SGexuVne+9G0JiGE+v1Dk=;
        b=aky0evdJlS3G2g6Of/ffL1AlKTd5jO5pPQUSnU5bruju4Lsr4LcpvwV+ietRwqRj2L
         WIGuZflNU3GY+jnu+eQqcQQxY0VgYpqprK1upcw5SrGScqiyXYoPnlUdTpkNOH5B5A13
         IcYzUFQwcKpisCLXBx/J0V8QUxb0777EP71sKQ8/K5grU8oMef1zDY50tb2Y6/18xXyF
         9zvO4+BZ3fWF/d79UZ4G12wfhB8Rbjm0y6+57kaB7eiNPjTn+owlReNcd4pRilqiGZn7
         RxraJIEKcghG1HcjvbqJHtkuUpMHqXjQxblOBvt/pGTk9x75UxBDOlaPduMG5QLnFX/n
         J6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788077670; x=1788682470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YmBdbxLkPCMqqCoIfbI1P+SGexuVne+9G0JiGE+v1Dk=;
        b=pSg3hEqqnyJZFsp6n+i8VJF1kDPDfX6ooYBFrBoYV9vq5G0HiHxs4y3tQvOc+n3zG5
         //zAfrBoV4nlXxBRHGxU8rP+XYMWDYAl7zV6AgJtyzwYRla/8Ik7y9v5q0FSlRyKOAkX
         hlSuOr8QJfcrYr5KThgGyHPxe6virWVqStTqmg9PLkPhh/5E/2Vn0JJxP9BCwkVOqBFh
         w5MB+NrNz5NuL/yl3acuzAwoBurKUUDYUgRRhTzMy/SWyvTbtiUkLHyPMchgnBwlV0SS
         5AgM/uFXTlND6HLsu05U6CaZgYrCMebdZUnu3iKI6ltQOdn+LP3OTjymeUzfQ+043iio
         qGaQ==
X-Forwarded-Encrypted: i=1; AHgh+RqSqV9zPTNLioVAfM4huC/DF8LvpZ+cQpLa2JQ8yQYg9a6K1b8P+dcqSqSlH98aQDQs/whwRX6zBslI6Q==@vger.kernel.org
X-Gm-Message-State: AFuF++kbQLwSmwnxWk6Z3o9RPVQcRckrM1V+zUKfVX8wW/4eRQf4CY6X
	Ju3MeimGDsRohW0ndUYVLqNI9Agq6ffKsoSTSM8J+KAVDUzBh1Upkk7jVZtNWQ==
X-Gm-Gg: AR+sD10AykKYqT7y2QmduE3JwUZ44XAsogIrcO+z4+QzYLDUpQGc/H5kHpVQr6i+lYU
	z/xpgXDVj1aXs3S585/vpFdfFIcTPG3mz8cXPXfhRfRNkZAvqcGAlLfivazz4+XKFw8r3WGu2DV
	Ehur83iOCfHNbC6jK9j2MRE2kus61RRcvfHnzs2daN1H/NLCAF3l4B64rXpeNFUKrPXmX38Opap
	eouk0MdJr0lw1jw2GeW754TPa17SAueZy7wq3Zt2gg0SWDc3Qs4aAguj1QgWyUmF3JV+QsAnVg8
	Vm0PG++psw10rtuLlsgjieryIs+QH+VzBTmzqgDtsDINepqVe9vJ7bvWe+umrc7IrCmuTI48m70
	AZFILCW7B7WmE9AKrbjl/Fsen1lVLYJNx2DPNC7jltwDpvX+cNRu4xtA76W+xSAkn5QxFsc+y4I
	Qd76PE1PF6vHbFFfjK8bauPbQMdaY7K6chp/0lZQyTpQ8WRxo495H6Wf40onoHjnJV
X-Received: by 2002:a05:6a21:38e:b0:3cc:917f:f302 with SMTP id adf61e73a8af0-3d26784f3b5mr32989509637.9.1788077669650;
        Sun, 30 Aug 2026 01:14:29 -0700 (PDT)
Received: from Default ([2409:40f4:101a:c47:80b4:fa67:fe3f:eecf])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f32f656dsm2668627a12.5.2026.08.30.01.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 01:14:29 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: jeffinphilip14@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com
Subject: Re: [PATCH v4] Input: atkbd - fix uaf in atkbd_set_repeat_rate
Date: Sun, 30 Aug 2026 13:44:15 +0530
Message-ID: <20260830081415.15187-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <apMJ1qoPOffbB0t-@google.com>
References: <apMJ1qoPOffbB0t-@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 29 Aug 2026 09:34:48 -0700, Dmitry Torokhov wrote:
>Actually I think I was wrong and Sashiko was right. I will probably pick
>your v3 but I do not like that we do not clean up/reset LEDs properly
>on disconnect.

Would cleaning up leds cause any weird issues on reconnect? We could reset
LEDs though. Compiled only, but this?

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 41a0d55dae0e..3d0e58be5ba2 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -963,13 +963,16 @@ static void atkbd_disconnect(struct serio *serio)
 
 	atkbd_disable(atkbd);
 
-	input_unregister_device(atkbd->dev);
-
 	/*
 	 * Prevent work from being rescheduled after atkbd is marked disabled
 	 */
 	disable_delayed_work_sync(&atkbd->event_work);
 
+	if (atkbd->write)
+		atkbd_set_leds(atkbd);
+
+	input_unregister_device(atkbd->dev);
+
 	serio_close(serio);
 	serio_set_drvdata(serio, NULL);
 	kfree(atkbd);

Thanks,
Jeffin.
