Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7F94D98FF
	for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 18:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856863; cv=none; b=uIY3WfDcJONSzaJmKStZv3ql4fnG5WmYC971fZvl9K6cl8w8iro7AG1wqZss8/0JGUFCMZLvB8gTHwuOvrAyJb3DZfdjfP2gM+vT+INyL25QJs0R3ZEQQj4/QyqFzxqYLvJsWyEluRf8JQCogo60txBhweHXoul7rDoedDyqTx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856863; c=relaxed/simple;
	bh=Rt8ALBK0oQhAgyKgcFtv4DDLxR5VZFbjwVXygxIm3jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcHtzjfC8pmmfdHdJQQWRZ+SKHe7xYRwHcqf+pyE7HFv7SgjOxjNED0d81+hSVnDDw1vziLH2Lar54BWDYDjTlGv+uu8LdQso9VIBiidhqTDtm2CP10jZh4fpYYUA+zcUBEnAdgs8xjqV6gh4ZySF61J6DLj4RtcJlBhWuW3tC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3xYvG9F; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3xYvG9F"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-482e1bfcc63so81070f8f.1
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 11:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787856854; x=1788461654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DXZbVhYz9N3eTXaQaEC1u1/IkHAm8yMqNG5vDMny+/w=;
        b=D3xYvG9FpQESwJheX2sSzz2TYs6CEaxA22WhQcZl3Bxiq7KIcCnK/mBkFjnLfnTxQG
         mYo5n966ckm/tU8UItoVzB789UHT6hYuG1voIXMkQ8pUBoGFGJo0t/H4rasM7BTZIhVf
         KGMOuuJQrGBr5rP7+BHFzP74PYE6nbo77nbCdBcudXt85AHcyZtfQm8JcejDP8aBJD0c
         uefD05tTZAztTQv9vL7VjoIThsNYobRR3YL3lxbn/eONsDEySqH5goUIrKsyUCF1M6Xc
         CWFUsQo4r00AILpm27TwAxTrzIEjuyBVkkfFQvEeD6lSgML3W6wHfEeIAOX+1E3HTyll
         wWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787856854; x=1788461654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DXZbVhYz9N3eTXaQaEC1u1/IkHAm8yMqNG5vDMny+/w=;
        b=d/H6ORl9HW54HttQSvmE6RFGEGATKAMpmZyt8/n7MryXfFZRj0+xOwbvlMt0cIQfrp
         KTjs09fLexiJaWO7ybWHw5UFqWeadk0PkHTyl0zhDsoUnBntAC584tzYYT4QMiy4blTj
         DilHQ5YqUtc+uvcAKNjQ0S4Q+4sjbyWiDseQYgbBoF3vHeb7aufJCodRgHJ6De2HhULW
         IXYB64mU3KGcg/74MBE+FFaSeIzWj1Wu7x4qOhUqU3Ad0tC12M/KfvZfG94vp2kHouwT
         QYmkZ4n1qA5WWdToJo7y05VpIil/vxE6DHwjuOo5wahKRnc9qj/hnxWZ3ejVR/xMl/TR
         N3xw==
X-Forwarded-Encrypted: i=1; AHgh+Ro4HAAna5u0fRnjzCAa6bFDXaBCmQRXMMMfei2uV9wurihd2nhL/D5g0NdwlWrWDw11dmjeJOTOx4S7vA==@vger.kernel.org
X-Gm-Message-State: AFuF++lv3gv1bTgv3lRfxi3bCFdkK8cR+h06Ngibk/XUvbjhmzAXgir6
	UQOJR1pCZLE9bOJolhtgLQwCSgVfiohTgarx0buHoAWsxpqepH33y6/L
X-Gm-Gg: AR+sD13pbAu6QUYGt//MyFsNeb1zNl/88dDP095J/EzHdG5oKYDK2Lz0PCZKYEtQp4/
	N0qGTVsqz4ISszGBFdPFmjY3nKpqD6ESaBvLFdsDSYOanmzgem8qlVJetSJzUZ0e8rEtudU/0RF
	GEoP5dDitDADXHG+tYMOy5n81QNsO4uIOT0/G2dgxg8MYwrLfi+ChTAamKhJ0316AjEh9Iip2tr
	TSgcB3uA9evGauW3SnUkzfzCPyUfPqHmAqElL9IYUDGHCRGuVPQokpt5/6iIxMbpU7ObGSq9Ttl
	Q3nzbG7PfKnEAHRUoaBh+aPYs3tV2VQ43XvIFVrGwwoaoKrVZYxbz432GvRtQUkcdGTj/qkoIPC
	fmbYYodGwJKVQOfxFVp4kwrLQvjgZysNkecZ8nAp+eottX5P5eFSKM82RUFy6SvaH5DXUQ3iBrN
	KCO5g+RmDvdLkU/d4Jfaer4ZbsDuriuei6wmLeknZTDaEluItIySeTS86oD3s=
X-Received: by 2002:a05:6000:310e:b0:482:e627:8e4d with SMTP id ffacd0b85a97d-482eab8aea7mr11109477f8f.8.1787856853846;
        Thu, 27 Aug 2026 11:54:13 -0700 (PDT)
Received: from m2.. ([37.142.156.156])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-482e28f854dsm10980986f8f.36.2026.08.27.11.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:54:13 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] HID: ft260: add UART and GPIO support, plus I2C fixes
Date: Thu, 27 Aug 2026 21:53:45 +0300
Message-ID: <20260827185345.10224-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827132718.GK770273@google.com>
References: <20260827132718.GK770273@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 27, 2026 at 14:27 +0100, Lee Jones wrote:
> What is this?  4 device drivers in one, shoved into HID?  Each
> component; HID, I2C, GPIO, UART, should live in its respective
> subsystem, surely?

The FT260 is a USB HID protocol converter, not four MMIO blocks behind
an MFD. I2C, UART and GPIO are HID reports on one chip. Mainline
hid-ft260 already hosts the I2C adapter in HID for that reason. This
series adds GPIO and UART the same way.

hid-cp2112 and hid-mcp2221 already register an i2c_adapter and a
gpiochip from a hid_driver. They are not split into i2c/ and gpio/.

A subsystem split does not give independent drivers here. The control
and pin mux live in one feature report, and input is one raw_event.

System status (HID feature 0xA1) is chip-wide, not per USB interface.
chip_mode (DCNF0/DCNF1), the 12/24/48 MHz clock, i2c_enable, uart_mode,
UART configuration (baud/frame/flow), I2C reset and I2C clock, GPIO2/A/G
function select, DCD/RI enable, and power-save are fields or SET
requests on that same report. Probe on either HID interface reads 0xA1
and then decides I2C vs UART from chip_mode plus bInterfaceNumber.

GPIO is not a third USB function. It is feature report 0xB0. Which pins
are GPIO depends on that 0xA1 map: I2C enable takes GPIO0/1 (SCL/SDA);
uart_mode takes or frees RX/TX, RTS/CTS, DTR/DSR and DCD/RI; GPIO2/A/G
are UART/power LEDs vs GPIO; GPIO3 is wakeup vs GPIO. The gpiochip is
attached to the I2C HID interface in I2C-only mode and to the UART HID
interface in UART or dual mode. TIOCMGET/TIOCMSET use that gpiochip
when the modem pins are in GPIO mode. Changing UART flow control
rewrites 0xA1 and then updates the GPIO enable mask.

Input is one hid_driver.raw_event. It dispatches I2C read payloads
(0xD0-0xDE), UART RX, and UART interrupt status (0xB1) by report ID.
Dual-mode still has two USB HID interfaces, but they are two pipes to
one chip. There is one 0xA1; there are not two register files.

USB reset (the TN_189 workaround) resets the whole device and rebinds
every interface. Idle wakeup uses chip-wide GET reports (0xA0 / 0xC0)
and power_saving_en from 0xA1.

UART is still HID reports on the UART interface (0xE0 / 0xB1 / data
reports), not an 8250-style port. Putting it in drivers/tty would not
remove the 0xA1/0xB0 coupling.

An MFD split would still need a HID core that owns 0xA1, 0xB0 and
raw_event, with I2C/GPIO/UART cells calling back into it, and with GPIO
availability depending on UART/I2C mode and on which interface probed.
That cell-and-core layout is this driver already. Splitting it does
not give I2C, GPIO, or UART their own independent devices; it is
still one HID protocol converter, in four files to keep aligned
across kernel versions.

Thanks,
Michael
