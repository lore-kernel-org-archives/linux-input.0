Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794101012;
	b=Loew+FN08szrfqKUPjylkVWDTHF+uolQvNt6sbt21p9DDIFikwgLDKsV1Zuh9cERKgku
	 IXdA3Hr+nBcocUAAqKgTlte16FlDBDdm1KW5dZ9ns2bVw58zDnF+Nz59wjGcvngq7PFP8
	 ddW4uFsRUMvPwu2IYcWNg6cOxcSeSU+nkpgtNbBF3aPBGx5LBg2CjT5mXbh+9zTm5lTdl
	 Z5PxJrD7IsGS690wq6vUsOmAVe0F1TeXUfvd+BCAIOzdbxeXWE+NKFtJxyzvjItCPz0wS
	 Y4Z171cMFh+q2TqoGH+bKCAgwqEk3H/Bxaw63ekzNxj3Comw6MZAyl1OIJiWwce87sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794101012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EaQPKJIgHcZvrcBYOXtJ/XqbYityXldTm39GT/47PWU=;
	b=05y0hxJlV6TeKd8xR+8r3ZigtfLmzw5Vcgq7liZe1Ytxg1GrN7xDECfVjG7XCpb5xTlP
	 dON8fkVnBvCLBSufFI3X2c3Of+gSjy5b+k83tNHEM61FFFBmvtL/eGpl0zpvB2oGABkH7
	 oAizRCM0vqRJqpdFFpCstM49T3oUokJLHrC1yPLViQmuZTYkNi1829SkG7z2K3MlGk9Zc
	 eRlTE6fErQe/HnvUDksRYGeeFvmVzEaZdkg8+tTn9Va6G/HJOc/Tbp2MZ04clXl+AUj78
	 tNJzfviZclNcdqiI70WOyEtkRcxscIhzNC77+aj/HihEYe/Wa25wiYoQ8wBSRb8ApOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ve2niqA4;
	arc=none smtp.remote-ip=74.125.224.139
Received: from mail-yx2-f11.google.com (mail-yx2-f11.google.com [74.125.224.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A151606A326
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 01:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A151606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ve2niqA4
Received: by mail-yx2-f11.google.com with SMTP id 956f58d0204a3-67a3f0c460cso41120d50.1
        for <linux-input@vger.kernel.org>; Sat, 07 Nov 2026 17:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794101011; x=1794705811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EaQPKJIgHcZvrcBYOXtJ/XqbYityXldTm39GT/47PWU=;
        b=ve2niqA4RDDgqG+tXiwhezhKV6NJswF1w8qz+PAiVqAlFyszJ747lOV6zyz0reC2oo
         yTj/ZXUixO8tzwURePEyX4s6MjwoJds/GXeP9+3LWbzHrnKop5kbdcqvB49a55P31421
         j3ilVims/jD1ENNWTKmYPtZuOEoXo4dE+nJ10Q/uQ7uKVFcdFAp6VOpWD7M/D3VzNwIO
         DFPhCk12Wgg2JRjAPfQP3mBXJ/YVXX8QOqelCM6gZU50wg7u0X/K0diqfQ9nvXmMvRJL
         FFt7EsQ4LU1xFLkC1d8HwHp8TJm6opmUDdT+MX2weBj0/fPXsLo/zfhm4ve+bojCd9IF
         XAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794101011; x=1794705811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EaQPKJIgHcZvrcBYOXtJ/XqbYityXldTm39GT/47PWU=;
        b=d8O93ZhXmdBZ2rI7wsNgqTz8ZXZDetpwqeeOXKoUOUjngiZxj5BpV41sJa0adtesuW
         zO/0NqjPRZbHguGl8L4IpSPGi5UxZcqVl2qaqIwEhDNqEW4bHKY8hRiO5quBzdUXD3r/
         vDnc8N64qcPhDAHoYhvLB1mW/msoRKPwuNbd5s7dHqEV5f6iSupQcIgugrO5SoDavOux
         FYbe0UB7WKTJTKz6a427LGsX5vRtMo4IN/1wCK3ki6+kRZy6xYP267SMKBgd9YOluipH
         saSpfS5VzhZrKTYc0ltvznUiWNHG5BR+ZzJN3uiV1wwE2cwL8L3ZKPhhBxHmKvqdGsgT
         6fiQ==
X-Gm-Message-State: APuU4Z/KBSoNOO0qep41xe/OMaSTPh1C4LFv0nynsV8q4DSW/TmnR3sQ
	f1TG1easg+w6ImG0OJmh85ilQMX6GppZayEwPUhTsibiUeIQabnOkCKF6FfpgrCY
X-Gm-Gg: AYBFou3+RpiJJhSJ5ToTXKAVxW+C2cM0tn1eEpX7/KxubsNSpGyqNQLfeJX0wqWSLOp
	cmk+pnZNFfEXPpytznN+m1D4gSA65QkoVApBoHsqBw8sbIkvklZUU5z/euui6OP/6hZYvG4cOlO
	JdS4v33CqVq+Yk8GDU2lSFoEPtB5Fssp6R3eHRiksyTBMGq0XcH0CPS15bx5KQg6e1T7+zLzygb
	Vr0bVajd3eQ7BMpu4ozKK2JKEcY/SDYbnOGd0LofZJ89yFBEhO0dyaT+8EwHBUGdqdb1rEO7Qie
	nUfNdnU4A9Mmkq8u0ZgAtgBHUzHwc+3AtIQwI4xmLlTWfVHoE6s0u06cob85UNP+on8B+GJssMB
	BGJ4fdF4EGnZo+M+NUmJ1s5Pdpa4q98drrTFn1Z0ntzol+ITyT7oiH4j8u6RfeaomFM9GSSbThm
	dU9S8EQcJzqXCiUO3JPtaZu2I1Ol+i59m/FglbIT7mpQtFJLlk2pfygIEhtOpSVQoT3LxZexZSA
	WnYLCp80cZicS7KqHDM14HXMQ00qzVeowkeMClQgqpMkAVx9zieOYUrzGT8S4vzVYtdPJSTMydO
	L/ar9XIwvGWz7uty0ucCrpOzGzLmKJc8gieLbpM+
X-Received: by 2002:a05:690e:458a:20b0:67b:f91c:109c with SMTP id 956f58d0204a3-67c3d97b1bamr148961d50.46.1794101011020;
        Sat, 07 Nov 2026 17:23:31 -0800 (PST)
Received: from linuxmint.. ([2802:8010:9a07:a501:b0f7:cdff:6e05:69af])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b36c09705bsm4706447b3.43.2026.11.07.17.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 17:23:30 -0800 (PST)
From: Nehuen Lian Bova <nehuenlian.kernel@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] HID: wacom: replace sprintf calls with safer alternatives in wacom_sys.c
Date: Sat,  7 Nov 2026 22:23:27 -0300
Message-ID: <20261108012327.89115-1-nehuenlian.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANRwn3SnB97Oeg4rKBiYX2DD9r51Km5Cf3kpnAn7s2xd42c0BA@mail.gmail.com>
References: <CANRwn3SnB97Oeg4rKBiYX2DD9r51Km5Cf3kpnAn7s2xd42c0BA@mail.gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> If you're going through the effort to use snprintf the string, you
> might as well also read its return value to check to check for
> truncation (return value greater than or equal to size) and handle
> such an error condition appropriately.
>
> Jason (she/they)

I didn't check the return value because I noticed in almost every
situation snprintf() is used, the return value wasn't checked.

Anyway, would be a good idea to return -ENAMETOOLONG after 
checking if return value >= sizeof(bat_name)?
Or using scnprintf() instead of snprintf() could be a cleaner option?
:)

--
Nehuen Lian Bova
