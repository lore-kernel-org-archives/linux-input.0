Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662583D6CB6
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789492132; cv=pass; b=tNMgbYgJJOEHp0RP6Z4TVrvHVugCIoFhq9LObqpB/2LelHMruI/i09tV7JdmnDoMu+SmijRTapgr3kaqLskx5qq/yQ29SCN5ugrE1no5SRDadLtP6ex2cIWZSyvHK2e4jkstBXtVBb/7DSScCOpqleWvkf82wK19s5v+sgqSMIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789492132; c=relaxed/simple;
	bh=blp040WEZ/pWVvS5aj0TSRQkQsEVtwydCA6C7Dn8Ilw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qIiIbY5hzWSo8bnfrTbbSKkEeS0SF2vl/2+VOLw1VAuVdpnuek/K+gdtTrhI3tYeunpg3w/1enh4+nkat0PIxsajCscX715BiasFG1MUA3OpmEC3mesokZiplrtpcZhaFybNYqjMti9IZVF3XnGbd0bF85/FAkDOqFDBQTNKseA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHgMx23+; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHgMx23+"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c2790ccso2102338f8f.1
        for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 10:08:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789492128; cv=none;
        d=google.com; s=arc-20260327;
        b=TtQ22fA0Yg5gHlssxYprMU2E+P0CpqxWV6rSS0sfZov9WaiNH5vQrqkmI/8IKg61Ec
         +Tm1bxs7vWqRzVKb1ZZwzZMsZJe0xcNu2JJwKnLhRnkqcHURyVEGS6b6PWP1ze6C4r7g
         B5Rk87WRipQSx0D03u0vDGeJzOwuUW/QLAlcLoJ6dWPlszzO3jmbtJVtQRCljTkHOFZP
         C3OmVKaGks0+fRwxogxKV4kHXS3F9OWRc+MLlKWvh6edDQ/7NIuzp/+aVfpGO23VQn1S
         NxspxFS1tUFD2PWn/TcpcpX055xzjMah6Y04ZW3BLWah+OxR9tIa/ltERui4E/LFiKlb
         aWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=qHH+3yvmffeS6h9m+Lk5rgUSw3v77W44xk7wtMZuSf0=;
        fh=I5N2KTxEDKp55vczuccNG01QAsM1HI1uo2asqMFrn90=;
        b=RpC5qz+L8Cv7RvThGOMd43ZqOEjwBNCZ+/KKDOPxW0QVBnH1UB74pDFkW0DWavYsnG
         GSeu520Jet21y1QsjAlQ/AqI7/8q2BaNi+wHj0lmVMTGtvowHdgRmqxG5zR3gusiKXp1
         0XkordcNU6mBrc8WQ8LE3KktS1OGThh3dMVOgXNDn4HtWdSqCNrcKKwq77ZdPOl7IHjx
         VC4mucjr1KZ9Wn5QkAxDB7SplzR3N8uuvIcwLr0G87RnwktDfGqam3gboRGCo0y0qI2T
         5Im4GXMLicwib4VLifUl5yRpL2rAY8iCYH4BCYj62+lCa176lnjJZYCCfyCSXg5cXyXc
         4Qrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789492128; x=1790096928; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qHH+3yvmffeS6h9m+Lk5rgUSw3v77W44xk7wtMZuSf0=;
        b=kHgMx23+2+Fe/aLw0Jlb6qSQsBLM9c8T8W9DQW5fe4miedGTTqu3/ayyT9VjvXfyp3
         OEmUdImeZoQvQAHs52l5qs15/4uPToI8Bh4j12sr2qpYivnPUB8O4in9ExdWjcOTI2CW
         ZAerKwY7aIhzYNER+PJQqKS8PzhpXJXU7M5LEWQi005RdSjm+DFF+zmyHCA8fUJrIOqI
         FuEKh3uoJ7phBkWXX9teHTGaVHSprToTt3Cwmgon7IFlhaH2kS4B6ncFojvtL9mBKnQM
         k9TEJVDB5zIv5AueOyWbM7zFZ6fNPcX8KABQYK/1qSwY4ppYQjawABW63BC9lwo0nef4
         oBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789492128; x=1790096928;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qHH+3yvmffeS6h9m+Lk5rgUSw3v77W44xk7wtMZuSf0=;
        b=bkgNWb1J9dWEflLQOYc2mX5xhTGRzjzt4IDDQWDyuK4vhP5jE0FicwGjMzxBZRcHRy
         zUJ2FZZMfSelBWJS9dd7FkDZKMzoUfe4jSlB1enMBvPXkDttda8CIRNHJ20kd1anrp7M
         ZJmWNmAipr30Bcc/YgpQyNuIsNa+flDxFoQm62MuwWOH+NwfHd+le7x/s7qZl4y5rGzl
         HMuHjyQmXcqKNgGdm+SQpv8Rz4CzbypNBmVr7bSMhaCJksNAE7K2G17d3oTqs2Sv3AME
         HOMPFdgEnKLB8zA5sYB95m+2rMpOe++JvnnKMqEQ/anrL1DVxuS9CZJpXCrPPOpGwP86
         SARw==
X-Gm-Message-State: AFuF++ldxRh0cG9Z0vaBsSbiTGBWc1uoWeEKGzsst30Do0Ii6jGU7G1b
	yYaUjDNIIq1sD+PpvRlMuW4bB+tb5i6W1KDJ+HfLiO22y62fpyYwuXxsvOMlo6oFZ349I6QO/sY
	zdqYaikqAgw5rFhaXttL2VsnYXkWLMFRwxQ==
X-Gm-Gg: AYBFou0fCx0zWsmEnCjEwawqjlI9jyptGUm8CaLTo0Qo+94pSVk9ptqKv95XVrCPsh1
	Gh0JBBPHjISZK1zR6NiOjldvLWraoBUmqOBfGBK8hUDVt48V+7byDxIA9y1iBIfecy/hG7UgUK/
	FD+YgSs4Tdpy0pJlai9qKtmzv2RPlIP/23wJwdh1gF5h5+x5gTrpBvPXDPBEun2/+Ch1/RMGDK5
	MPWLFv4dHN8AuetJMtoNbqrlp7pwztV/glGw3AvtXqpztFrxtyoTgNUr3n4aJsSdyzKFZjxcbrQ
	kuXLryX0gYkqwsj6PwlFdiPobSHF3SaW5HFpE51goQdT1BbyRXq5kC16tHFSlMgz2w==
X-Received: by 2002:a05:6000:2403:b0:485:943c:886d with SMTP id
 ffacd0b85a97d-48702ad29bemr18125376f8f.7.1789492128161; Tue, 15 Sep 2026
 10:08:48 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 15 Sep 2026 19:08:47 +0200
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 15 Sep 2026 19:08:47 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andreas Kotiagin <kotiagin.andreas@gmail.com>
Date: Tue, 15 Sep 2026 19:08:47 +0200
X-Gm-Features: AcwNN1XlEL0aKX4N7upLqLjN1uGgasnSpH_DEZF_fpHY7mZrUbHZFuWq_od0koY
Message-ID: <CAAC3AxYXbXidvKQo-QudT9AMQK0+hLStE9djqr_5YwAki9K-Pw@mail.gmail.com>
Subject: [RFC] HID: battery support design for Fractal Scape USB dongle (36bc:0001)
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

I am investigating battery reporting for the Fractal Scape wireless headset
through its USB dongle, with the intention of exposing a peripheral battery
through power_supply. Before building a substantial driver, I would appreciate
feedback on the integration and coexistence approach below.

Descriptor observations from an attached 36bc:0001 dongle (bcdDevice 3.21):

- Interfaces 0-2 are USB audio. Interface 3 is the only HID interface.
- That HID interface contains consumer controls, telephony, and vendor
  collections. The final collection is usage page 0xff00, usage 1, with
  report ID 2 and 63 payload bytes for both input and output.
- It has an interrupt IN endpoint 0x84, max packet 64, and no interrupt OUT
  endpoint. The complete HID report descriptor is 177 bytes.
- There is no advertised standard battery usage. The whole HID interface
  currently binds to hid-generic.

Source inspection of ScapeCtl at commit
b5ec62ccbbb090dec24c614c5580fd1b2bf6fdbb indicates a status output request
consisting of report ID 02 followed by f1 21 and 61 zero bytes. Its parser
uses payload byte 14 for percentage and payload byte 18 == 1 for connection
(raw report offsets 15 and 19, respectively). Replies echo f1 21. It uses a
500 ms response deadline, a default 1.5 second polling interval, and also
sends a separate keepalive. Its README reports unsolicited 11 21 messages
but warns that their presence byte is unreliable.

These response semantics are source-derived, not yet confirmed on the attached
headset. Captures across power-off, range loss, docking and cable charging,
comparison with Fractal Adjust, and the need for keepalive at slower polling
rates are still pending. No charging field has been established. ScapeCtl's
root license is GPLv3; the planned kernel implementation will be independently
written from protocol facts and hardware measurements, without copying or
translating its code.

Proposed design:

- A small dedicated hid-scape driver matching only USB 36bc:0001, interface 3,
  with input/output report-size and vendor-usage checks. No hub or unverified
  wired-headset IDs.
- Normal hid_parse / hid_hw_start(HID_CONNECT_DEFAULT) / hid_hw_open, with
  raw_event returning 0 so media controls and hidraw continue to receive
  reports. Audio interfaces remain with snd-usb-audio.
- Cached power_supply data parented to the HID device, SCOPE_DEVICE,
  CAPACITY 0-100 after validated input, STATUS_UNKNOWN until charging is
  established, and no invented voltage, current or energy properties.
  Connection and stale-data semantics must be settled by measurements;
  a timeout must not be exposed as zero percent.
- Initial 60 second polling from scheduled work using an output SET_REPORT,
  with a bounded response deadline, conservative backoff, and synchronous
  work cancellation on removal/suspend. No USB I/O in property callbacks.
- A way to pause polling and drain outstanding driver requests before
  Adjust/ScapeCtl configuration sessions. There is no known transaction ID;
  separate hidraw readers and ScapeCtl's process-local mutex do not establish
  safe simultaneous device access. Passive reception can still cache valid
  status while preserving all incoming reports.

The v6.18 SteelSeries headset driver is a useful integration reference, but
the opaque vendor protocol appears to need more than a generic HID battery
quirk. Does a dedicated HID driver fit here? Is there an existing preferred
mechanism for coordinating such polling with hidraw configuration clients,
or a recommended precedent for a per-device polling pause control?

I will provide raw captures, lifecycle/coexistence results and a tested patch
once those outstanding hardware questions are resolved. This is a design
inquiry, not a request to merge unverified protocol support.

ScapeCtl source inspected:
https://github.com/charlietran/scapectl/tree/b5ec62ccbbb090dec24c614c5580fd1b2bf6fdbb

Thanks,
Andreas Kotiagin
