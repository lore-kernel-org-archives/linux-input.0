Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475D028373
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 02:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788487372; cv=none; b=N0hdIG/cyAfbX3VFoMyCucKpk3aHmpbPEqjJqb8B3Db+MONi5386NcbhXQVnWlXvgIsJNjAJCSHqIovHIAbZF36IquUm6YAE7I34W4lwlGK1kWlMTmqqLBEqE3xrjpclzxwHOwLBR/7omB67xJI8qdXd3zschTkM+EEfC/HA+SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788487372; c=relaxed/simple;
	bh=34Z8DPG6Kp1PMhLkp+d1BQuCa8F7adfXlCWa4tGzx7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBZIecZhWgtI4xCeSxLHS9rkpRhAcKgyAyWEA1uLN6W1AeiL/rNRkYQ4Z8Ki3lzbqxIGMDrNCDH8fiesgCdWrB2k8IBDTe/qaDeJTIrXWOUo8jpd05zONrdZy7N6p8ikD0MMZEKlNsjZ15Rw9FZTBhEOlh0rtSI0nPBefoXFdXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTY7jrO+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTY7jrO+"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2caced6038eso5305845ad.0
        for <linux-input@vger.kernel.org>; Thu, 03 Sep 2026 19:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788487368; x=1789092168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=34Z8DPG6Kp1PMhLkp+d1BQuCa8F7adfXlCWa4tGzx7o=;
        b=LTY7jrO+vAtZxmCQ/C3ElmbukHQTIoTnnF7+J9gmgB7AFCx6FqwTZFWEltbwc4IS5E
         P+zrfqDAD/e0TZj4bde38JQZ3ZJhw0kd+RXDFKAOo9huVWVPUD5sd8Xw/kE/Dg+tJE6y
         6ITzhAVUiWUJAAZHltlM80hqggESApEP7jeVpUML64L64YPc3aRMM0HbjU8HsQo1cS9e
         6qfgP5EboopO9uIrg9C11mgn32S1NBf4cLrKp+5QWM3j/O2iR70NabmgDLXUsHxZ2MY+
         D/NAOX40ra24+SNevUFSkDNiA5YFcy/68WNizwLYHbv1xewOvLBr9GRFFUhW9QY3rg6l
         juHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788487368; x=1789092168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=34Z8DPG6Kp1PMhLkp+d1BQuCa8F7adfXlCWa4tGzx7o=;
        b=D/rq4QEZYuD21/bEQXEQbP/ynerqyp4zT95LayVC1pULHTrjZJWztoPcM9dj2XGbz+
         yQnYsuAIW3Gp34sB/R7F1W5n+k5PVcxcQssY2GzLT6hzh8qdsiZ554W6Avc00AEQkio5
         8F8TILgtVcLnJ6dAg6083aUF7OFdxlLikriVvy5Z4H6C+LNYpUI3QMNGpZNBK5XXzdLw
         gY3EwKqt4yBfxkmENJsP5+zbYRvM01+vpuYlnuTOoRtVeuKgOSE37iAA0BXXOWGN3Euf
         mRU8Aa7Ho5Q9X2N9iJT5XxNbYdxC1ZHUmA18+XmiEs7Px9FIei7RRxE2wioeKnhX++J8
         EBGw==
X-Forwarded-Encrypted: i=1; AKwUvBzz3Lu839p8pFXcbPuf94PkKv6fwMJ1imgq8jyU2AbasNhWDwbDa3NFWc9tEhdFM1UIitgW/vD2yQ6LVA==@vger.kernel.org
X-Gm-Message-State: AFuF++nJh4ovYLrIN5Ecz9+JudxHJj544kea411G9gq391Yrwb2KpfbW
	uqIouMb2WWreSsoZKlUNFPsvTQaKMwHJ/RRn7PybxOXErKtn/+ikq3xkkQCuyQ0x6n0bIA==
X-Gm-Gg: AYBFou3KNKuRADf0UrD3r8MZMDx+D//wFwgUee5amsYpNtx88Nf0nuLHP5IVzVWAh6b
	YpFHzQVltW3z1mDp8FR+/GHyxEle9yDqN5AfUtKCE7Fk4CYhk3nM9uzMgGJLkf4oovWboIrR6Db
	xblbi8om8KEF5mrpqWdMHCLH/FCS8J1Z8gig0ni2cYQ5VE9uvLAOcCpTMhdsRkrMkFe2S/20stD
	NvhTen1GMZ0U/yAeWXgNavbaByfvUarrfeCP2Zf2kfBzlWiYgJs8cSxndPoqFFvKj4mNj8AL9R9
	0zw1CiVF7HDkhld7TQUt6L2+za82KXWR8Twbuj6FdR2wdXx3PsQfv7anif2gZ1cfQk5eHXxFAvn
	T/X/fO0EXJveJOEluym5R++vTkqq9XyDMe9P0rKpFRYmQjdiNwuPPP1uMjiYi9K8XkbCt+bHt1G
	9AQmJBRrZ7d1gQhTyYZZdWgcS/UqHLE4dW3aKMSf0aNIHkOdD/RM2dDJ01zkkGh4LNk32AN058j
	RFe+m2KyPim7zjRRQHoCUj7vd730meW+436ws7q+CRBqBnNvhIddGYfJHkvVO/ez54QFJF9
X-Received: by 2002:a17:903:8d0:b0:2d6:fddf:a890 with SMTP id d9443c01a7336-2dafaf31cedmr99763755ad.6.1788487368267;
        Thu, 03 Sep 2026 19:02:48 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1495acf7sm2983195ad.25.2026.09.03.19.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 19:02:47 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: killertofu@gmail.com
Cc: 98lawweijie@gmail.com,
	bentiss@kernel.org,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ping.cheng@wacom.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()
Date: Fri,  4 Sep 2026 10:02:35 +0800
Message-ID: <20260904020235.8227-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANRwn3RFVDy+y-fpLkb1mfjiKyQgp1Jg0tyBTO+G0xem2s1jkQ@mail.gmail.com>
References: <CANRwn3RFVDy+y-fpLkb1mfjiKyQgp1Jg0tyBTO+G0xem2s1jkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


On Thu, Sep 3, 2026 at 3:36 PM Jason Gerecke <killertofu@gmail.com> wrote:
>
> I'm still finding the above paragraph kinda hard to understand. What
> do you think of something like the following instead?

Your version is definitely easier to understand. I'm good with it!

> Other than the above language issue:
> Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com

Thanks. Should I submit a v4 patch with your "Reviewed-by" and the
updated language, or is leaving it as-is (here) just fine?

Regards,
Wei Jie
