Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAA93932D1
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 10:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654154; cv=none; b=ZZCxPbNhdZNPeSPBpWGcF+6OSel3nh7R56DIWExpW0lZvYW2tWMm/824Uxzrcc+QEpqPRRN4vBr7Vt+UDWz2xl/Hu91nxRrtuM0c/6SXQtZ28i4eZn7jRKLC5S1Cd7XmxKK21gmA3icu5H8DVBZ3fkIxYcY5EBnDLXue/1BHQ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654154; c=relaxed/simple;
	bh=jtCCi2Wp04CyykRR6gbHaI5ls9wV78uGhCwV8aDkh0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jM1HEENUSpZrol6kCA5frKLZp/LIhITa/bwBTW8X/dzwSeqMraA4rKasfSxaG0UfnbWZaAMuX0MFfA5RWce4cZR9w8EOA1243ZyPzrH2fu/AqorX4C8egOZfkcCwTKNwG6c2Q4AI9u3iCWNfnkXN3Rph/mJahdwP6tMVjphI4oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oojvx6UG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oojvx6UG"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d6fe26ef1cso73845ad.2
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 03:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787654152; x=1788258952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mAGdwPTKNLhGYXhLo2utD2z0sUdRi88IP/nTJQo45lU=;
        b=Oojvx6UGYFPKDD1kCiIDoZ4T+f3sprf4kKEqW9Te5mLhfQ0zB1bDckZvQKZKhj0iFA
         cLHP9VevCC/wWkS3ydp4YO8xUFFGNSSmwuP9wBH4G3rmegK8CqtYW8157FrXo6a1NLVN
         RuhltVPwbz6ng7KaOChG4mZA63ShNrVcbWjLkP83n2w8uiTtLRZEbXE+Wf5vYbeaU8iO
         ynk06fHPLxCs4FubsS+rZJ0YN8lC7DuT1r2Bny722/xx4cG9VCpN+beV2pVUy+RoauD5
         tHsPHKmStkofbMnytQJOhPA7cLW/hvCl4mKsHEAcmJduiAdoFy9SvrlNhPuXhhJnhVhE
         8l/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654152; x=1788258952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mAGdwPTKNLhGYXhLo2utD2z0sUdRi88IP/nTJQo45lU=;
        b=UrqjVVpaW11b3dcPV4qsPAHnnhrZiwFmtrcfzxGbM3CDSjlT+G+A1Wtr/zx5EayL6N
         79jIW9fVBDKi/UtDsN74KbWgkP8cznR7QO4NtZBXxBymK774ZAFtBg4sqSCcUr+ADEms
         1QCGGqqnp12RQ9LDypsFbxGDS9xfzsatTV/9nuO+M9XefE3dbqpLP9jMmAKuwdjR6EWH
         zq6sRqxLnVsWm6wlbXtiOQ/m+jLLAcqqWogSEzsvZ1gOis/uI/TrEXN6G7x4dMphUHVp
         q99utg2+4tQXiIFwx7jK4LbG01X75DK2J5Vv9rLKDHd1amgma7Br6v7yITXcERP+SykS
         euVQ==
X-Gm-Message-State: AFuF++n/LKFdp4E3c321uRPlQvTWv1+6nMsJsAqwWiin7mYB2+QJWzBK
	QUhYOEM2HsRuIMNQoveAds9Vq+rf+UW79cu0AYQY1WcczO4sK6+apCEsr781FUyp
X-Gm-Gg: AR+sD10lYXgPNhqIDimzoxiaWh8Rgk/iH+Rgw+wlGWaNUew6mu1afcEo2VxjtdQYuX1
	YZzknkaR9dmYIMxyEY0Hs4olTZjBCKthRfMFU6u2+jmW1fnAgvYxYcMiN3ArtwEi6liOrxe5ruF
	bYMAUPRKPmNiwk3ufBwO/WJ+qem+ZiFVxbK7Upo/eNBVfnysA8b63TisfMfbjPa0pUOFhx0OTJz
	cPrTgh5ERkvkbZBDGxaK3XfZgQz/RHnHHjIKE1q3jYQPpt8ZX6JAxXtAdklErBdggsjWgj9jkHC
	ONzCZgkHyp5NF8/hTiy9q5QvGjRZK4sLv45mmitxXJnSxdD4ACmwOLmTnm+InKoqO34EegwGZZq
	3b9JHYgP5Q21ezu+vuhjMxpXtWtzjRCPTc+txIlVzWwXxoEd/toFfE2n21olcYqNx+WADUxBnbA
	FQcKtSWOCZvTmeGYQxEMcd6vslfOkSSxMwfH9fYWGutWeAzEHiATQ7+lQRkrj+znjdeIYnDUAst
	nJp2XbbHYYPisRjQN+wbhdW3qpcLoVev6VMWg47IPHOU36EF+9oxJerPNQBgkP84hLPv/CTgFuV
	S30BbUCmRPikP2bRzbupwVfR
X-Received: by 2002:a17:903:1843:b0:2d6:3c22:993a with SMTP id d9443c01a7336-2d670b4c980mr144776515ad.3.1787654152431;
        Tue, 25 Aug 2026 03:35:52 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90c0de2sm37209225eec.8.2026.08.25.03.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:35:51 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: 98lawweijie@gmail.com,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()
Date: Tue, 25 Aug 2026 18:35:45 +0800
Message-ID: <20260825103545.13421-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260822120926.153849-1-98lawweijie@gmail.com>
References: <20260822120926.153849-1-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Jie Law <98lawweijie@gmail.com>

Superseded by v2:
https://lore.kernel.org/linux-input/20260825103104.12090-1-98lawweijie@gmail.com/

Please use that one instead.  The only difference is the Assisted-by
tags that Documentation/process/coding-assistants.rst asks for -- AI
tools were used in finding and fixing this bug and I should have
acknowledged that in the original posting.  The diff is unchanged.

Please mark this one superseded.

Thanks, and sorry for the noise,
Wei Jie
