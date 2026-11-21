Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795281809;
	b=4o6IyRoO3WO58ajQn9vbGSj9i/M8AjzdREYTHNAZRVq86/RAibm3diPd9uqDKFS4BoXB
	 gYnXt9upovUZ23dbC1ib7atfzTRkfDipozzFr+eoTSbPlWF28wZpJ+orddfDgeaF7QDX6
	 XDJliJ53TeEg7p9Db+YfeHCoXLpLvPnHez6LqYwG3tSTP19XMUxOGqwC5qv+ttaPhhd0g
	 l+7N5cMOmk84Y1FFUh0ayjf4NiA3tlRotYfTxAsyaIiSNea4bZl7NYoo1RdvLdjxK1iJN
	 SWU/8QJfiUa5gzcs+f7LxUOsM2vg+VRhYAgiwKDRJVrgzXRcAzdDSKK2GtL18Q46fZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795281809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=A0co6D3pA2qw7YPiyyMMIlKC8VVSD5A9Jz422WbS0Bo=;
	b=SQ02sa3v7UZ7XtZbolKFBzMRl7Zvkn+fYfzuwcp8cKNt6i2iwZ9KRZBl4kqotnNvFXZI
	 sdXoMnECvbGmQJr3h14vQxhGHof4O4AP4w70rvoiJunGnryPDXmxlmBmotw4PWhunXmle
	 g8XnZFFyPxpi5IbTpb7QquteAjOe7xfRkmIa8aAOngtACCyX+iIMb6/fo3n1Boka+jqVD
	 7hL3m7sUJLHLTrXkOstWegxHvL8XfNMGAJZZ8HWOKeUwvqTvgPjZeahYy83Y7UVqG/SXU
	 Cg0DLDR958EWIBGh9ZoxsGAynOxQGtRfOv9oBRYE9rX3gx1RSTB4ZBikiol8hmBpGsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P8LmpFBe;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04C2606A32A
	for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 17:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A04C2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P8LmpFBe
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3282db206d3so5626336eec.0
        for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 09:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795281808; x=1795886608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A0co6D3pA2qw7YPiyyMMIlKC8VVSD5A9Jz422WbS0Bo=;
        b=P8LmpFBeeEHcocflIPBIlS1K9w6pTlbbXxxF7rE+383oIBdTofSXp75DxlWBqIC+TJ
         xDrN23DlA7Nj544SQyBZaMWQvuIxEv2xKdV+fmylyy/8wDTKBon7ajKNGjyUiUwRe6zD
         U5/K8xllqUiZ/yQDDwGJnWVEKHle89afY+SACk/iJIfVKTeUD3ddBgc9zwJTZvJ0jCjC
         ct29Fvv7B+KhPwIZ9BDxcGEk/7IDUJoj0zSXwAjuai5Kqt/JR6Trw9EGA3NWM5ko5HNX
         aTDfE1b40TpFlFU8oqwlqHxL3Qq1hT3xbePp7/sKIH9yyMYLAqIiiu4DaELWMcvIqcT3
         CPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795281808; x=1795886608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A0co6D3pA2qw7YPiyyMMIlKC8VVSD5A9Jz422WbS0Bo=;
        b=UAQxKDUU20cB2ormx6JUFTHVceKfem5dn485vNZXepzoo905lJK6J3n5scxOWZl+aU
         EPGVU/VX3Da4RPH4D/hNBk/g9R4RYBG52GRdNktPee5tEy8nkBPc+IFC3c63I1sOtHbb
         tFkwbzN85HzHEsZWOWrO37Qc8JTDistYPRFDmjk87sGArTtDcRB+pxgfhhjC/G0nkTM3
         hfXxewOR+LwAJ2gvG/jONSAcgnWdtqTvuJhkhlxjo+vVw1y3ZcnE7KcaqvA7Gc9w6l2C
         6gD9FA1KdduT1BonUYgzN2LkLyuXESFyBqNMN+5kpo3vtt1kIwSPz4CrQmqC7vrkqs4V
         GklQ==
X-Forwarded-Encrypted: i=1; AL+hErEiyZ/nUVupQ2LoRSQMx95WKDNUru1WWe+tgk80PW87YjAmlHTtHEcN6Q9RW5prIZ9AtoZAJWqy0U/xvw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9AOFhj4qKi89iXI/U4gmqrPF4znS6IEQVRlRT+FWKV++iO01ZX
	2ZFq5InWXOOTdPmpGZZykJVESwNmrkPZ3rVsArCg0gjAg4Wjw6a7IetC
X-Gm-Gg: AZFdTZdDHBFwhLRNQt3714079K33Nwwh7GoMJIJxS+0DfwLTwzwEU89SHTYsmW3B+F6
	kk6DvhRZZxFdL0VSrF3Xb7nE9GOGs2KFdcldx7jo1ANd8dapOiHbdnmq350z+yyuxr1AloCyNkn
	cd1NTgHL+/RSLQ3ftkLYIpTxMy9Vq+Sbp6uv8EL5fAFLNz38/0z3/JGMcVeVFq+Gifx+E/m3NRC
	VMMzHPIT6OnU2etYyacxxoE8M5zCFE4w42uzwyBAlV+13twfE/QxBFKEBnrTp+Gta3WZ4a5PxLw
	HOpPYegZ8TnRyNWkwJ74SxykiGDRNog1HduIqdv6A5zhZeQXbyzTDZZaF3drJ7veY61I1wjCr7h
	Htw/0RbkUfQpYy5tiSpC42Nkwk68keHZtdAWoj4bpft2V+Sc0mFwG85FMgJJIZEjAf1VqyzkH/k
	SyN++yHQQXpw1PuWWWPhKob0X3rfW08MXH5jAj/F1oz+1ujLJMPTF6AWNb48dYBE75a208qVTHW
	TlOoAEZ76/wkT805WrCwbLPOOa3GagbSRKzj0DAlxH7LO2uTGrrCKdprJ3GMtABLMlfgZFRA4c6
	Tb+gBPf7q89oDFWjEZnwueruYq03LSwHN8nF
X-Received: by 2002:a05:7301:fd16:b0:385:8744:658f with SMTP id 5a478bee46e88-3858753a876mr6679805eec.28.1795281807535;
        Sat, 21 Nov 2026 09:23:27 -0800 (PST)
Received: from DESKTOP-NM9EKIA ([2001:e60:8509:ba6c:4c23:efbc:89e:50d9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e96bdsm18360832eec.7.2026.11.21.09.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 09:23:27 -0800 (PST)
From: Joonhoe Kim <26rote@gmail.com>
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 5/6] Input: aw86927 - handle the AW8693X play and boost register layout
Date: Sun, 22 Nov 2026 02:23:26 +0900
Message-ID: <20261121172326.846-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261117052112.32527-6-xiaqinghuan@mail.ustc.edu.cn>
References: <20261117052112.32527-1-xiaqinghuan@mail.ustc.edu.cn> <20261117052112.32527-6-xiaqinghuan@mail.ustc.edu.cn>
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

On Tue, 17 Nov 2026 13:21:11 +0800, Qianhui Xu wrote:
> AW86937 and AW86938 keep the same register map as the AW86927 but move
> two bits and invert the stop handshake:

Tested on a Lenovo Y700 Gen 5 (TB323FU, Kaanapali) with two AW86937
(chip ID 0x9370), compatible "awinic,aw86937", "awinic,aw86927".
Both probe and a force-feedback rumble on each drives the matching motor,
before and after s2idle.

Tested-by: Joonhoe Kim <26rote@gmail.com> # Lenovo Y700 Gen 5 (TB323FU)
