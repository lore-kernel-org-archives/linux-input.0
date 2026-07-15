Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411011A9F87
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 06:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096481; cv=none; b=M/GIKN96RY2g4dS/sgDTgyvw3LFKiQlleZv4m94HzHN1zIBu1+FzsSl1zyyH5s5P65eRwbOHNw6rq0mcBCITuFfKaSILg0dmrgHZzVOV+NmbUL5yiSmmUnG9HTEsUBt2aaRi7HXhcJULhQVt1l8VapdkU6L7+wPtc089IolgzFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096481; c=relaxed/simple;
	bh=8oneNuTPvrj8s0MKldXDp2LqzuJfuNLreLAOuRzjQtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQYJSF9KpCzbJw35oFxAIQ2IFWZwrSQRAx5oppOeQnnNlOuINgruptNmNwygruKhaPBiL0LGLRXmAWUz2QLbP4YIkVl2GPPM8QeGrzJz+zCl7ShMOZY2AdFYF1vcmmv9fAgvRv7cZoOksRRae9EIseFIY0QK6Undm85Xwx6GECA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OH9Kv9r2; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OH9Kv9r2"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e9eaf04bfaso1854732a34.1
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 23:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784096479; x=1784701279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LxB5892Gv+ZQSWhWKdOfUMiixSzBac5s7jzifFXhxdg=;
        b=OH9Kv9r2G0FnlTDE/jYDmXBI9CdGEtxUIi5/Il5DA+87NXICx+5dyXM87H4ozGXQWp
         VWXBCRG34ze/0dGlRa3s4ircnaelJhe2xhp8UA6ihAtit5ile0EibVra7LRouuCL93cM
         jDOa7jbANsRp13/Al3yWecrAhaZ8c0OnMkApQ1qVvA9tA+96mRbEMHHOTeGc74fPJZzZ
         EJf0C4w+CydDL+2qmszyxZlibCX16w7TSOeOdOYU/FoldFWeXnmRWJpCnJNBe/CZdP9s
         yvdHoIiShwmydDwRt2pJ/rdtDIzdDnaPWvXqUj8kcs9/FQYhStAxNIneQ+IkcMndfuHV
         dyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784096479; x=1784701279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LxB5892Gv+ZQSWhWKdOfUMiixSzBac5s7jzifFXhxdg=;
        b=tTr1g3iaDnOU+jJdFxtRMesWkeSbMAFz9/BCdDVK2I6OBMDhUTyIu9gouTo+7lS5SS
         zVUlLLRAifBW4tK2ym5hrT/pyIucPNuXebiv3KQZs2TMuKI4Ng9nvGTZSkoDZZoJLF9C
         rz/7DTV1j8/KgiRQWz7SmDJDL541+hm2rU0+gfmmn//a2NTQruL4iOXAmrLngVszTt8z
         o/nb3b3sDE36bUPpzQtD8fUWwTkS0aVg/BaMccwA0RbjPyoKt6FLuTQQfILzKCaVu4Mc
         DQ/fT+2AQLgCxt1vmPzHOFrSJwZsPa2pxK3a1xdNDLyaGM+hqtcTgkcFQMv+4k9e/18D
         lHlg==
X-Forwarded-Encrypted: i=1; AHgh+Rpv6RE63gh4eLiBEDcFPCdYwOHZR4vhITDx54ta6WRJ0jl7KADwi7GlTQZNDY3/5DiZvJIf7L21+OOCuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaoTVfVQNC1CfmqasvNwcUlhA7wNO+0BBN4ex6cWnXMbsBWPn+
	3+Zd7W1eVdyxhdjAOPkNSlk4hWMKt6fCQHK81uhiDTd0bqF0Awmyt44U
X-Gm-Gg: AfdE7cnfu5dwZUz/v7fuXvMMwlayHCHhIGHhkYzWG+4zGzFOn1RC0d4Xf1jeeMkiH0r
	Kc4b+f2ySfXcIy6OyIcm3kYU0aB0wSo0bRt9bXDX1UB7q78BTWF6Pu1ypwjQXSwmLTIO7AE83bl
	rj1sqfLByMWw8VFcB1AyxFYLrErT4RjQ8qTcou87zJocgoNbXTj+Dbo7Ki5COUjEyDPEJQuQRcF
	NaXIFJ7IPm+pc1QCPXdpzzHDo5BENBtZ0oa9GTsBlYDlXTrkLLKVi7WXzjJn+lxNYykRGRKBjhX
	6GpEWhe08yHLvbt4lWZma2h44FrpZCNFQhEabv3X4YMdAkXckg40hugW8Hbod3yA2yyAdKL35bk
	uF/dHuxWBv3oZRwYYWAMEevge2ytG3b/rtkKEm3Fdnt0FQR8ck72We95eeY9SgRwveb7IjL+KX9
	nsHT1dVSUYn4xl
X-Received: by 2002:a05:6830:25cc:b0:7e9:8867:cb23 with SMTP id 46e09a7af769-7ec59d20770mr874309a34.16.1784096478979;
        Tue, 14 Jul 2026 23:21:18 -0700 (PDT)
Received: from desktop ([2806:2f0:9260:f072:92d3:78b1:9863:130a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2b79c9sm16655936a34.22.2026.07.14.23.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 23:21:17 -0700 (PDT)
From: =?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
To: Alec Hall <signshop.alec@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
Subject: Re: [PATCH 3/3] HID: magicmouse: report charge status over Bluetooth
Date: Wed, 15 Jul 2026 00:20:56 -0600
Message-ID: <20260715062056.616625-1-pepemontfort@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714101235.99447-4-signshop.alec@gmail.com>
References: <20260714101235.99447-4-signshop.alec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alec,

Heads-up on a textual overlap: I posted an independent fix earlier today
that also touches magicmouse_raw_event(), so it will conflict with this
patch:

  HID: magicmouse: prevent unbounded recursion in magicmouse_raw_event()
  https://lore.kernel.org/linux-input/20260715053526.574725-1-pepemontfort@gmail.com/

It bounds the DOUBLE_REPORT_ID recursion -- a malicious device can chain
0xf7 packets and drive magicmouse_raw_event() deep enough to overflow the
kernel stack. Mechanically it renames the body to
__magicmouse_raw_event(..., bool nested) and adds a small wrapper, which
lands in the same region where your 3/3 inserts
magicmouse_report_charge_status() and its call site. We share the same
base-commit, so whichever goes in first the other needs a trivial rebase.

No action needed on your side; I just wanted it on the radar so it is not
a surprise at apply time. I'm happy to rebase mine on top of your series,
or the maintainers can take them in either order -- the two changes are
independent and straightforward to combine.

Thanks,
Jose
