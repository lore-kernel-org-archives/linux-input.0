Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC37D30DD22;
	Tue, 14 Apr 2026 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179209; cv=none; b=QS7OHaNE7BokkgHyaTnjKIcW0ASXQvjjMGq8QveyP1sCpKalrFlu5wZ6rEjynF0i2QLfEGGOK52L3GbZdNE00Yp6vEqHD6WU3BJ3ngZAmgRdORJAG/AUrIUuZnH5AnIcUaytnBJxrJHpu/ZqXZcaBey3xroOhmlMYe79ST63KIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179209; c=relaxed/simple;
	bh=j64KI+guVrSXW821QIUoHqqnXm4MTEMyvSC9M+RzNMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DpOziDTFQrHMLoATwTR9qFrkOiFl5ClTUZeTBZtj2maI3dNWacj6uucMz2YXIfJxthMJkq/F8nyorldq+AevSuT5HZ8y+WE1TCVq9X4bvau0n5ea7vKsTFbCCdqs+F9t6SSV7tHZNY4SzlYQKHYDIHAGsULM3Vc8xr66QP0uZsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=fpuI1VQA; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="fpuI1VQA"
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 80890635B040;
	Tue, 14 Apr 2026 16:57:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1776178666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Wx7tLqu8KIMBIKkyLk50Ims6QN0cyOEAHnXNXmyHfF8=;
	b=fpuI1VQAieMz/U3tUu27+44JGrrfixtNqT07t0kzQpaOfHy7h/FdwF0NR9HLeZd41xQxZg
	KtHgXgToqwlVvD/ky0nKVRO7EVw8D8CDs//ik6aeTeI7li3xHnmjDkYrZO8RraHnbo+VWh
	MAU27dKZTO98x2AwxRtmjqDYit752Ow=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Subject:
 Flood of Event data for report XX was too short (X vs X) messages in 7.0
Date: Tue, 14 Apr 2026 16:57:31 +0200
Message-ID: <6256259.lOV4Wx5bFT@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5091446.31r3eYUQgx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
x-ms-reactions: disallow

--nextPart5091446.31r3eYUQgx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org
Date: Tue, 14 Apr 2026 16:57:31 +0200
Message-ID: <6256259.lOV4Wx5bFT@natalenko.name>
MIME-Version: 1.0

Hello Lee.

After the 0a3fe972a7cb14 ("HID: core: Mitigate potential OOB by removing bogus memset()") commit I observe the following flood in dmesg:

kernel: hid_report_raw_event: 6 callbacks suppressed
kernel: hid-generic 0003:051D:0002.0005: Event data for report 22 was too short (4 vs 2)
kernel: hid-generic 0003:051D:0002.0005: Event data for report 22 was too short (4 vs 2)
kernel: hid-generic 0003:051D:0002.0005: Event data for report 22 was too short (4 vs 2)

This machine has got an APC UPS attached:

Bus 001 Device 007: ID 051d:0002 American Power Conversion Uninterruptible Power Supply

Once I unplug the UPS USB cable, the flood stops.

IIUC apart from the rest, the commit changes the message verbosity from debug to warning. Maybe hid_dbg_ratelimited() should be used instead?

Thank you.

---

lsusb -vv on this device:

Bus 001 Device 007: ID 051d:0002 American Power Conversion Uninterruptible Power Supply
Negotiated speed: Full Speed (12Mbps)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 [unknown]
  bDeviceSubClass         0 [unknown]
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x051d American Power Conversion
  idProduct          0x0002 Uninterruptible Power Supply
  bcdDevice            1.06
  iManufacturer           1 American Power Conversion
  iProduct                2 Back-UPS BX1200MI FW:294201G -302201G
  iSerial                 3 9B2105A23830
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0022
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 [unknown]
      bInterfaceProtocol      0
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode           33 US
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     745
          Report Descriptors:
            ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0006  1x 6 bytes
        bInterval              10
Device Status:     0x0002
  (Bus Powered)
  Remote Wakeup Enabled

-- 
Oleksandr Natalenko, MSE
--nextPart5091446.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmneVdsACgkQil/iNcg8
M0vCTxAAhJWncmjxcSeMKt8CXjqzgk1K1cFRXluMKJrKv1HUDA0I99cVeH5TUWvM
oauzF3LErftDRzhNcUFX9cYDGc81QzLYW78nMn4zazMnyI/tC43tovbKTGMEJ63k
usMgEPfUowVPvu6c9+Z+OoIf63NP5R2FNTqBLzRkZPiHzhhW7oEbwNuouF6EMoFy
+b1hxYpsgge56mhKVXs2/DbbJr7wJI1IxTqWiiIvUkfeztDtI15+mspzlUKb1Tt3
UFK7y2WYz7KjTpUjAoMPdt8zKNNNy0GpYODgO892N5uPD6r7CA8gFsJt3nr4Omn5
B15KAmS1tP8PuC0m8udgXYuYwboMsO4qtGCYZ1USyFapgJRaAIeKgE5t14kfr3tT
9rW1Y/Uknhc7ocyGlyVirca2j9R2cDP44UTTCdOrODYa1lQ1ohy8XX35Nfc6bXuV
94VdUf9lGuHALOlQq9Wisuz4/mHgB18uLWSzPA8zGItt2Y/fDi/riIV9GOC7u0G8
XcncNGO8XucWKuLoWJKqszG1U7pV2GKPUJUgjilxurvwyVfQ63EmqJu264YOVxsR
Q740W1qeiSAeicfGjKwMp62EsToLxp09ImIn85HE0VzeT/+Gxi/holHxQN3pHmT7
yYI9m3hmzFDsQLF07KSkWSIOp1tI7QNVUCl+M3nGY7HxcpyltR4=
=vhC7
-----END PGP SIGNATURE-----

--nextPart5091446.31r3eYUQgx--



