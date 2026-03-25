Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F53ED11E
	for <linux-input@vger.kernel.org>; Wed, 25 Mar 2026 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454909; cv=none; b=mr3qPqMm9nKzx+fw6mgxM8Uoo9oT4QjvM2z90KX5xiyqzkg544qMI/Qakm+sNFULJExstVN0B6IN/zHcOU/GeZK+/sJ0RAxkDAiDOiyDCQc4vDHgklJSNHtGj+OV+IKqw6dePm18P6uZ4blfkISP4Em8rQ3hRXM3MlbRNNxepL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454909; c=relaxed/simple;
	bh=hNNwjsHedzC//Q9OJ1PxWjJ65mudSwkNnDyt7S2u1vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQIokDVfctjTRmXKfBtwHlaLajV6WYJRCQ4I01t+4bqW19BZB6+kzMeiDLAu7GSKXnvhMfrxmknuUb2fH4vkOGsdtjbuLBp5LiEbkKcYLbk/GVdcGe1TeuovNLNg85vfy4icFGOn68OLCkeLH8BfZVo2bl8VoKVFSCe6TpIKPf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clJIUZkH; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clJIUZkH"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12a747e7b2fso975c88.0
        for <linux-input@vger.kernel.org>; Wed, 25 Mar 2026 09:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774454908; x=1775059708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M17iBYC/F74Bg+gul2lB6f/cFM/aLJkZMkbSd6hygpg=;
        b=clJIUZkH41qGVMiDA2PYJ5BmcpUqHxDDxnCQ9AO3RS4db9KnC7MBoTDDaapUMlyw6n
         qE/em8tvVIZCxR5Jy3HUyqoCVKkyA0T//9nfYhQmQcq7E57A9TAS6OY4RjNK8tX8tYN5
         aoCSkAEtVYqZE3PhH8V4MUJG6va7jLCWPbWdjoAl4dOZ4CBaw10QugLCa8C6W8UIVZKg
         fEgUX4bZnwVs+pE/wTnEawVSz6IGyS1JLbatQi/NozomPIaGLcly3oAe7tXF+VlJIfqp
         GEKbfkC1Aim+416DSlCWydXn/6wIUhmUpWISWUaRQYLMTkhN8pUGkmmJuT7CcSoFKKdY
         jO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774454908; x=1775059708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M17iBYC/F74Bg+gul2lB6f/cFM/aLJkZMkbSd6hygpg=;
        b=ZXfPllNoXGd7ENX4E6ELoUhVKHd+HbBpm1KUWHhoFB9FED8BWBrFrNsUFCoGCLMSDY
         p1gumZQborAnys+oTxqAXlLVgQ4einlrDkkXvgjkvJ+WnXIWr3HcJHpHCSmj+fOW6Dnb
         +3LljJ8QIVc7kzCx0iFh6cB6kygI4x0BNLXam6wuRruETGnfWikHIcbCjLvJvhkJfZZT
         RgCaDCfWpTdQMxsu69LEDeTAnw9svGgkV93HuaRNi84D8QY8CwZodcHWslR8quT6dXY0
         ZcOIybap2GaNAGzgOYfCpAA+hgEaJj3atG+FNvXLsZOCxfEXHXqz6oumEZkTOpZcTQKK
         tGmA==
X-Forwarded-Encrypted: i=1; AJvYcCUfUAEr0C56ZnpGqM7Z60dalb2AjRHLPdZDnqtE608QCeRSGMgyGif5Ns2h0O/HsgcrEgQjzs8ImQv0Kw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/TlRm+YOhHE4FDuJByaJAzvwGtVhpBrBis/YsDNv56B18IeC4
	9uSUuBD37hYNDDKQqFv8CAxJH0B7X8LMxfO/Apz/Q0ytE2N5BEvwMqADJb+gOg==
X-Gm-Gg: ATEYQzygcJG25WVUDom4HCWnva/XncxiFozvFluBUTiP1EITlb2S2KOYc1LQn6B8Lir
	9EcZD0ugQfFBpXT5V/jDO4hy0UMsN7czAgLwVNneYsOFgUlZPxP9XjMWDzk4qXmE3Z0gmAMID1g
	aXgaZGt3pmV1cY+KCLTYrU4K6TJVvTw5G1uuPlLa90p4coJzdxnKiCk2fvzlGg8cFfpSmJBAw0Q
	h5SW3eDMLgRI0ZUSgG3i5xvumenisJapS3dolMMOybq47wbSQeWHMtCe71oZpoF7PeCW/8/9/3e
	LE+E7RQN3nUTLX18taMB6qEkNoFBs/ULkVIxa8bbHntspg90fZxkB7sxr43ed79i/qqG4QMjgGT
	JnpUZSnhG0sPwoRnx44XUhKLVTvUOrgl0CXJFPnO90dw2g8mfdrNYvCh+tG2o+4r3hvk2e4fOZF
	czxws8whhj14QJcryDS15Q28Hwkw3i8vESz1xhtk2RB9HHRbvfzt/1i24+8hIx9BYJ
X-Received: by 2002:a05:7022:ec86:b0:128:d3de:c9e4 with SMTP id a92af1059eb24-12a96ee7658mr1893590c88.30.1774454907665;
        Wed, 25 Mar 2026 09:08:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:b7b4:352d:eb23:66e5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aa6e5b9d9sm194018c88.3.2026.03.25.09.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 09:08:26 -0700 (PDT)
Date: Wed, 25 Mar 2026 09:08:23 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Val Packett <val@packett.cool>
Cc: Hans de Goede <hansg@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
	Stanislav Zaikin <zstaseg@gmail.com>, linux-input@vger.kernel.org, phone-devel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: goodix-berlin: report a resolution of 10 units/mm
Message-ID: <acQIdFQeUi5E227r@google.com>
References: <20260321073242.556253-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321073242.556253-1-val@packett.cool>

On Sat, Mar 21, 2026 at 04:30:07AM -0300, Val Packett wrote:
> Without a reported resolution, userspace was assuming 1 unit/mm which
> is wildly wrong: a regular smartphone is clearly not 2.4 meters tall.
> Most applications do not care much for this kind of raw mm value,
> but Phosh's on-screen keyboard would accidentally trigger swipe-to-close
> gestures due to misinterpreting small movements as huge ones.
> 
> Do what the older goodix.c driver does and set the resolution to 10
> units/mm to make sure the numbers calculated by userspace are reasonable.
> 
> Signed-off-by: Val Packett <val@packett.cool>

Applied, thank you.

-- 
Dmitry
