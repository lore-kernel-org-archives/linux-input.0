Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535443CAE7F
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 21:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790198114; cv=none; b=duiDnqQY1wBjIPk3SZsrILcflYsdUDD9nb63JRtxAv4Z4DyArr3ILccij7FhySj9S5SMF1t9chxTOHKkUX1Z1cmy5AUkiFQiVqIcgJ5g7l2FS6gAMUK+3nFLKrH8B5CD6oqN3OhPWYfB0ZiJ87F56/pVZUEshY16R+s5BKYUveU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790198114; c=relaxed/simple;
	bh=mbitNxCUMM39R4YGaQk34WmC5X+e/RPNv6Qj029D3Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SrXhfogyGwdfqK+S2vZfEDA23TZ5eyg6qjCS5CvTFBQ+le36J8vgFSBfPw9elHBXwFodW9PpoN8RRSRhaCzJ5G8QPRxmx26yrCiEtTmUMPvHQmpqxdeCoMfj+w9tvkyavAXcywYwnjjmLdm6isntJn5kpyh8tsShR8K9NMjShGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhYo52Jf; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhYo52Jf"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c24422d4dso1565131eec.2
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 14:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790198105; x=1790802905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+mi6zIs9P8zxgX/W5h8qHY1aY4dnKAV0RC3Zgyj9agc=;
        b=hhYo52JfAsD52kKOKQN1vkhHUJBQWrRWPt4r2y3MS3lKPx9oc1bJi/ypP+lNTlruZq
         4LJPrL3GeoQcV6P7atDgm2xB3f5PoP38ZenbeFlqd++Bs+Jkf4/Hn2zmX2gIQySlFL9i
         SzC4cxFGgt4t+VZsvHpv/qGrZ/kBDKi/s7BVy8cFrazyV49cbyE9e3Vu9x2RHOBAFKHe
         gcJrLSuBrhjsAObrldZjHPPahllLb4CwbLLxp+8MwBT5Vldo17dTfZYUbQQ6Yr5T+Imr
         HEp4t0p4oUE3GBlTENPY5PgCr+1CfWgqNQgaKZNjGhvfxQAiLE/8Joe1vDs8q8YJnLwv
         khnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790198105; x=1790802905;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+mi6zIs9P8zxgX/W5h8qHY1aY4dnKAV0RC3Zgyj9agc=;
        b=JMFtJNCZqSk+CSUz/sxU45iCaPimnkM0mExDhkgNowhLAQSQEtQ48fLS0m6kpk7QZt
         lhbwbElBNs6o3f4/wP+ASZVTctMdkXrk2lYl1mU9e+SQXJDetP3X8WAWuYuveaXzaOqG
         yslx08P7KSro5yey08tl2xSv/Nj5K6U2vwpGz8ENnLoN4qPM3+p61o0R9yt1bWUibYE0
         5OInFX3+HZKko+Cg1Q3wQzx3Its3Kp3Bu7XEH97yqL/D1VyZPvx1FAB+RkJDYUbRd6aZ
         8ujXMO1w5o6vHtOJks5bL5ixuTaRX6oZIB+aAxdnBEztVu+UjJJMjQoTolAIqfQ0qwnC
         M+MQ==
X-Forwarded-Encrypted: i=1; AKwUvBxh6YpjtuWCLiSersRH0ZevKXcxCemCv2HwQtywC9gwQx5zHCOvAQ/SxPWxqoKKMug8zLFX56aHeyQCkQ==@vger.kernel.org
X-Gm-Message-State: AFuF++naJ5RCS1dCv7vnHnRJiyoqB7M6veQj0EYMRFuchQPtLvHfnlSA
	kUkOU1G2V3Ad7s0iKuDWVUaGrsOANrkv6FiYlgh+qwESnkbzF0zBarB1
X-Gm-Gg: AYBFou3Yo4ESjNHMiR2VOG2w6vTxej1Z3bbdHUf/3bFQpaKtZ4jHbr5S/PzoMinmle7
	RDmCS82F9WbgF1HVFZYBBhJrmlo6iLtfNZkWv3xD5hJxD0qB7VzoRS/p917P999I1WHVjbTiLQS
	HY2pVpzE6Op/8JWrE+jG9BROb+h7BrCNe4vkKHlNvrCNMoH2VpMFnyS4f68+5V882M5TEPrjIOS
	Pc6Hu3/03eoce4NgzIg2H9eyKC/MkVR2yPsRj1sOOj4nycMATVreaPM4eIazJiEZAqaXP5E87/F
	c+Kl+7nExToyeLjwGuT9fTO4xsVtL6HjbzKVVcbcx0vU0NlMtuNG9ReyEArBi/g2cfcBZCDTwL+
	/2zaX42nPTHwtplaxdnuknIThTmHvFEg3dxSkhkKrdI2LV136IrjkWcC1h4phn2v3FGO19sn4Fn
	b74gYeVWQ/ZsKHKVL2WmSUM73I8PUGLHTvPyjF8+TCQZH0q31NLIbwKGOGYVUibGXf+h8/nX437
	GOgv5XWWk7Z9EjIc5ZQ9iwDfXxDxg==
X-Received: by 2002:a05:7300:b291:b0:33c:e9d:6d49 with SMTP id 5a478bee46e88-34003baa73amr302118eec.39.1790198105220;
        Wed, 23 Sep 2026 14:15:05 -0700 (PDT)
Received: from localhost.localdomain ([103.16.69.192])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e97236754sm6863234eec.29.2026.09.23.14.15.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Sep 2026 14:15:04 -0700 (PDT)
From: Aditya Dash <mradityadash@gmail.com>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] HID: hid-lenovo-go: normalize calibration failure status
Date: Thu, 24 Sep 2026 02:44:58 +0530
Message-ID: <20260923211458.32755-1-mradityadash@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <836F1B09-60CA-4A82-8293-0F9CF506E593@gmail.com>
References: <836F1B09-60CA-4A82-8293-0F9CF506E593@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Derek,

According to my observations, data[1] seems to give the correct status
instead of data[0].

device_type in cmd_rep seems to indicate the left or right controller, and
data[0] the calibration device (gyro, joystick, or trigger).

To validate that, I ran the left gyro calibration on my Legion Go 1
and failed it on purpose.

Here is the raw data alongside cmd_rep, its contents, and data array

  raw        04 00 a0 02 03 01 02 01 00

  cmd_rep    report_id   0x04
             id          0x00
             cmd         0xa0
             sub_cmd     0x02
             device_type 0x03 (left controller)

  data[0]    0x01 (gyro)
  data[1]    0x02 (failure)
  data[2..3] 0x0001 (reason, little-endian)

Reading data[0] as the status would report this failure as success.

Therefore I lean towards keeping it as is.

Thanks,
Aditya
