Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C085A3101A7
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953003; cv=none; b=SMemvwZj1O6El1aY7rXSy79Lopo3eUzGmg5BkTHkL+YPJs/pSDIzyDe1qPUjhh7vIQM9ga5AcPEAj+dPmObmHxqY/UtrF8NxIqMG5LU4fx5B0zCRa2KJySqo5Hetnjj+rrNRbwdh3OVZKCXhqUO4ZIpyxK2Znep8Kjzu1LXU8DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953003; c=relaxed/simple;
	bh=G00ST1jfx8BViNgMid9WzKiIC21VQAHDfCH0GpHBbyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/VsAMbimxS1ZAOonkRVxKtQWSxJVgh39hPE2BFmpv0O5U8LBj2HAm+bZ24tUVAwU1E+Cz3TxM26Ex6DpnVkbxfq8Bg6JRflbnLgln/WIVi51SakvuEVxsvtx5AmwFPmgvqeJ12weez/XJZblsDjrUwTYbOGJ9eVVBc7c++jUJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8/Uetor; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8/Uetor"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so2518344a91.0
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 00:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786953002; x=1787557802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iyPj3KHFQ267Ntiq3iQP7uG/RTI2ae5DGlmIRneVba4=;
        b=e8/Uetorb5NcKEIl2v8TCFBZ4Kt8aptj0MCO8aUCFxLF+rsnfFK7E58CqqB00QPt56
         oooNpDPyO+WlQhKjbeTkz1uKwRP4mAQhJOSBOe14gSVDFF9mQxB6qga9VXYDP+xJFCK0
         L6KnrNq6H8drsxyIWr4fToZMRY3twC9mKvGStQ4MM3dz+yV76WJtUTRTIY59PJejSlvA
         Oco98GSEmh92FJw9nozVB5kX3BleEDpHXwJdE+81/nA2YPOVXBYwbDr7p3PsnjKpevwT
         hJIRlJB890QaxpLHZNHVMiRK+LVUeIkLutXUa35U5vMMP7CJlq8SjcI5bx5JOK/+Bk0Q
         rnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786953002; x=1787557802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iyPj3KHFQ267Ntiq3iQP7uG/RTI2ae5DGlmIRneVba4=;
        b=NRcvMmwF6rISgt5v6rP3JrAn4db4T4ddJNXDbyDRjDcE8M13ZTFFqEhSol8SikHgRf
         mAAwlFnebyHDDyTfL6PNYBWhHD1h7xov/O7QiIYeC5Jw5rR2YVzOnSbTgUWLMxGOdMTH
         5Pwi//gXcwFSkQuAhchnI2UrFtjY3vBfUX1Fa5duSeK8e3cuWi1Hd/sK2Akqy8+yl07L
         2G23SBWPw1a2l03OnHDZxAWOBIvUmGZJcZ2mKJ3zEY+ORh/HNL5SJWqj7mGK4+LgTd+A
         FcxhKWLdZ4v3muUXJsi2qdviFMeaiaA9zINohGrRIslyYFdNhl4jNXqI/SNK7o1ELvAe
         Yk2w==
X-Gm-Message-State: AOJu0YxJSO6ssTqt6XNNRfXwKku5h9S2RZ3P4Sh297EV21NhSqRVaxxG
	rEBaJvKBVGk6KX4vZH0epQtAWuhYHFA9Rgvn0sVsBwYtGnE4J0qP6N3e+NOjwCU98+Y=
X-Gm-Gg: AR+sD13wZPqmrjzZb+5hSoPI+p7paboZ9t6665d7SPnKxFRDtMQicQ6iHSs1Culn8cI
	IRAhbl8yMpb43sdAYZUfFI3krMrh9L3C9fRtitYU8w1vE23m6L4RQ+TynZ1oaj4iTr7JqKnwXQY
	IqRukTxLAqGvulRFlpoYnhO6ACgbodm49OyIWTi/GJO0SwjN+JTTbvFUhPuio5uctBfVrs5ASJZ
	0CCkU2Idns0jJDlRiktCIpCdXmFVmKMchlJbauC1FIHtAdX/6CYB271EP9TX0eQt5iXJrfGUQCn
	u/MsSKzaX5OdCB5TtbjwzmB0lgNfkBshsHf8GNpKrwis7oThOQcnb+vpW7GtqdiqU9nPl0OVnOl
	P/c5jvhnPRVm1Va5LJv6rP60bghpmfUWHm7pIv4N82oCHUFNQA+BHpPO5dx4n65WSSl5zQvtf0h
	uCLLIei2NCcgbGVoy2momrb/D90AnnxUmSgPptEpVh4IIHDkVwsvPN/aoPtPmGAMT53J9vImzkq
	t88QiqLW7GeEmGFbgrl8hrwlQ==
X-Received: by 2002:a17:90b:1d45:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-3933b7c3b71mr24080140a91.1.1786953002003;
        Mon, 17 Aug 2026 00:50:02 -0700 (PDT)
Received: from arsenalgear ([2405:201:5003:b0e5:de9f:6316:18ae:75ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-326796d646bsm3776133eec.10.2026.08.17.00.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 00:50:01 -0700 (PDT)
From: Uddhav Swami <uddhavswami@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH v3] HID: add driver for Gigabyte Aero vendor-specific brightness keys
Date: Mon, 17 Aug 2026 00:49:56 -0700
Message-ID: <20260817074956.34366-1-uddhavswami@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715055951.15144-1-uddhavswami@gmail.com>
References: <20260715055951.15144-1-uddhavswami@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jiri,

Thank you for taking a look at my patch. I have updated the code 
to reference chuyuen as the vendor rather than gigabyte.


Thanks,
Uddhav
