Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A5919046E
	for <linux-input@vger.kernel.org>; Sat, 20 Jun 2026 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781973568; cv=none; b=g3/NvL4fF6OkrLQPJVCmWX4okrsJ1jgqwmanI9LMB/uC5wFKkFJERgQgFh2u/hnazkiWhq8QwxrHK4BXSF/LYu7eaCAcS/BT2fL0mq8cKw9HCTQl9ADB78hCbZwdZYLOVd4pak3Mx3NZtT/EjRkz4B/XXgMrf+WY/4FlxZU+2Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781973568; c=relaxed/simple;
	bh=haxd7f6tL5rzZqm9lNvJ4G/QHDZZOIyw/6DVdjGwId4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k3IxtvCmxRIgjVL9YlsrYy0g6yTsrPf3ouX4A1zSYZg0HfUUeRBRCQ3/h+hhIjEFxOFIM5EmRBCXWFdKYuoSuOwPvGD2R6roxUrdvJJwQJeFYZ7/4BC5sJnPrWtKfafd8Cm4uzpTqyyoGFh3H0F0QbhAUjsD4q89HgBxXxZuSU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zlYOE3hX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2ti3fjzx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zlYOE3hX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ti3fjzx"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781973558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=YkteGjANYaDNAmsvxKj6wfMvNJw00T3AeDpa3YWOz2I=;
	b=zlYOE3hX/Gehd2Oo7U1EfnXqZ2uj5eTwinzrNmEsDUv5Ukx1TOjy7oVsCQsyoj48zoCiXk
	v0G/0DusCuxYbAFEMrLRm9TavUOi5kIWxoAc1k/vJ2SPF6A3HAw9XtK2+c887pyqrrgwA8
	rD0nhvmGcz4FUDpGHOGL9GY7BGax0UjzRI6FZ6zeuKpIZpE2oG5whxDegC6EXZG8gHs8Mn
	Jtmwl5B5PUCaVzLm4sheBUKCT7K75LFAyfN3hEUvn1PtO+oW8+pyj8y+Aa2371ZEg7gq5F
	gwTM7FJS3POsMLIr4xbBTXZ37qdu8NPdkcyxF0kWDNu1ccTE6NXveDfcjxsmvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781973558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=YkteGjANYaDNAmsvxKj6wfMvNJw00T3AeDpa3YWOz2I=;
	b=2ti3fjzxOpBYYL8fAp5xfCRn71SmXZqQ9EH05LtueaQvzbdypltEzOlvl0UWbLX70ZugFM
	CtnzeMSHZUPKMjDQ==
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org
Subject: psmouse: missing pnpID?
Date: Sat, 20 Jun 2026 18:45:18 +0206
Message-ID: <878q896ua1.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

I have an HP laptop, running a fresh install of Debian/trixie and I see
the boot message:

    psmouse serio1: synaptics: Your touchpad (PNP: SYN3286 PNP0f13) says
    it can support a different bus. If i2c-hid and hid-rmi are not used,
    you might want to try setting psmouse.synaptics_intertouch to 1 and
    report this to linux-input@vger.kernel.org.

Indeed, touchpad and keyboard do not work unless I add
psmouse.synaptics_intertouch=1 as a boot argument. I am happy using this
boot argument, but it sounds like you are trying to collect some data on
this. Please let me know if I should provide any specific data.

John Ogness
