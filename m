Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB3E3264D9
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252343; cv=pass; b=mWgG37F/tE7Nhk1gCFem7XO2khfyymjKLad9XbQ/IusE2ocJ9lMD81G4LX02vV/JNK6bZTfoByYL2+AKb4A+vCyw5oqePm1u9o06yF6CCcpQZWnSmmp3qgm6J0ipRsJMhSUF4wbYBHyQwE8EJoKgyM9j00v9ANHD5XjL56GK2DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252343; c=relaxed/simple;
	bh=WGDd4qoUlJF6pNHRVdcMK8CvfS72uR+x1nJNYfTxDc4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=o7nGtiEXTnx8q9gs/H2LtxDcuJtwd32w0D/O1/osWSQ/v44ehsU7If3/ZDOpIel27Li0aYVDopIm9wGqqt2WtC0HXIAo/MM5ebXwbPJPL91nHxZdrmLgPXzmEYzqvQv76ke5F5Wcp1cd+elLFTlE/m0CLctjwwWQxvOQ7wfzTqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdvJlhDc; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdvJlhDc"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1712a04ddaso733372166b.2
        for <linux-input@vger.kernel.org>; Tue, 01 Sep 2026 01:45:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788252338; cv=none;
        d=google.com; s=arc-20260327;
        b=aufyB/Ye+LPcOh5kFEYMsFGB1vhnhBRuhpb1N4+0klx8ws5Is9JgZUiVIjphChFgZj
         3m4Gd9gwM7NnpOfVeXrdVKglPr0jzg4S9P5i6sk1Xzzn4atYBdpTy5F8YgCd4Z7GjCRa
         ZNMP8TMrG+i5vbCyBSNNHZgQtVAWHPaUd0ES8kqj+J7G8zGQihJG8DPbjlJTIVaeiMg0
         dMi5DOcdbQXVUO2wSv2QQ0NW0s8VRHuE1LMOu6OiIc7WYNuEWKXtIwUdIyXE/1egEcDv
         WSfC8OAbVFarbm68eAXpLNaSIJ2ASjVBDL2X8Tyhi7RS1pa5FJs8OYyVW+bKDemrP5Lm
         9HKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=WGDd4qoUlJF6pNHRVdcMK8CvfS72uR+x1nJNYfTxDc4=;
        fh=gtQXNMUv+d5XBmnIhaR5yd48q7DqCJoUCMYwI4pqK/4=;
        b=FtkSxrGdOQY8Xs5BHojHf1RV61eRaLV1yglrSysOSI/b55dZV0bPMAP1N7lGuIfNax
         txwCmKQUVxDWx403pcJJQUYo93HEN5tL0jC8xs9OJA4N9VhG//FIzQEx97N3cpOyfmSG
         11z0mHIkp4vAzaJ3NUttG6TyDSN3cqRy7MV6czC4KaA/JzDD6nXiv5PUwpVkd8wpdFgE
         ybszRwZLfRofOdzEiUwMruDK1QUh6gBpsj3SdCIdLQPnCSiWjYmWHswlq6ERMT3QOArX
         /Ro6TqkVFjfp0DOckATtJzUYpY+6/rBcv4xDMzxwafQ8Wyz+UbG7PKcDuM/kIYOplJ6d
         I6oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788252338; x=1788857138; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WGDd4qoUlJF6pNHRVdcMK8CvfS72uR+x1nJNYfTxDc4=;
        b=hdvJlhDcC2iX5CCLf+Yl+m+cEQYPQmDS0RKpsGCzuvGWyOROkiNaYJGL0QCp0NGHkc
         qLm/itDrWDnR1NvwcmIfs4qUtHGyh2FI9T7HJr9QBLvj2023ldrLmPfE98rvcqgsNALs
         4qgim5lV55woWowJGdAYokMk3XIzYN7yHLdZJlZhepu0CDeqDwgbRIkmSx9u9MbnYaCp
         5kc3nRf58qE5hH/7TfSop7fOx97r5mKjapbIF451uDZk3u7XnDK+XCP+TxmQk+0c/TIL
         n5NfUnFexHIgSvGqJniw8FYEgQAUhq5075lfx3e8C8+LA1F94AtDMmYgfAMnLCp7Y09L
         JcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788252338; x=1788857138;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WGDd4qoUlJF6pNHRVdcMK8CvfS72uR+x1nJNYfTxDc4=;
        b=Z0uO44ZwkFzuI+MGIXVOaDqZgiYU/QdmZJWiqmhlTyS2sntmz9TKuR/WiKo/LxyvFu
         RrB1AaNonp4WzmWdjvJnyTAVX8kNi3ECrtAM5IpReez/lpJS/es3eJdOS/EAgrR7QBzt
         yxx/EOZgoo+mACb6X1kTD9O6fG87O+0dChrYCu3xxgiwBkA3fXNokbevQiFUYoZqvB/d
         ZV0mV5hx3wHzZLrFHg11u/tmMhzW3d2CIM04PSFjFwv6AGFO9ob/euizVq2ooSOgECoW
         G+eVZ7m+CaOboGnYyU5tGgGBtKY8uSnEClU+DTeadebazx0NNno0vdGrwVX42SwAP1az
         D/nA==
X-Gm-Message-State: AFuF++lQeQqpKz5WIWFvIPtFVrERxWEoAciP293IDRjRSzub74cbgMr7
	yfmCo0+mQpCkomi0JQcyQCcHQYlfSmiKCRbLfDPUt2ArAQsZ4e96wue7ACzCF7gJ3K/JEP72Jjq
	K44IPjMb7NQwxJRY8hoe+rzyBdga+vNXFMg==
X-Gm-Gg: AR+sD136s2+9FC+iLwFl8OBUJHvSibpk9PQ/M/81xAfSqQB290vBbIiuKAYlWeFQvix
	0+7vlBDu7yb4EGb2B4vK6jZ6PlA2J6ecZ39Zcys0YJFB2W85kGHaWXWsASIzqLjrt61QioDRHyu
	Y9ypUPWj+8TRerk2MNFaV61OEnkgR96WYD+q4N/sdSUrH3XA9kYrE8QLav4Z8VtLVebZu+M/NPA
	zLBZh1/aM0CLPzADHBbPwfhdMtJS+rfiuM3bCJilsCnCTrnpvT89XJ6KLQDLGaAnc+TFr1dxJjM
	1Qc8JtvsX/TY3M0QwdSu9d/lruWo/PQfJTRpGkIIQ/EFBJ+1vMB+/cH401w92Eb/fj54j7522lL
	vrlhybQEBYBxLiVJQ2LSVjyyNfAO583oCIqbFi3m8uhY/ulXfW66arl4p5fOWJU6tbbrr
X-Received: by 2002:a17:907:c48c:b0:c24:4128:c19f with SMTP id
 a640c23a62f3a-c2557165b0emr1917585366b.11.1788252337448; Tue, 01 Sep 2026
 01:45:37 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 1 Sep 2026 03:45:35 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 1 Sep 2026 03:45:35 -0500
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: William Luther Zambo <wlz.litiaina@gmail.com>
Date: Tue, 1 Sep 2026 03:45:35 -0500
X-Gm-Features: AcwNN1X_tONmeLxfRUzmNghIYUu4b9O5AA6c4ZA6RiQjPbgwDRDb9Kar9OxWv2E
Message-ID: <CAFw-f_1BYzUnXf=eD2sVe7RrJrtzwDrMrbmmPZvGKvYB53EUJQ@mail.gmail.com>
Subject: ThinkPad L14 Gen 1 AMD: Synaptics LEN0411 cannot use RMI4/SMBus and
 falls back to slow SynPS/2
To: linux-input@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I would like to report a Synaptics InterTouch/RMI4 issue on a
Lenovo ThinkPad L14 Gen 1 AMD.

The touchpad advertises InterTouch capability, and LEN0411 is already
included in the Linux Synaptics SMBus allowlist, but the RMI4/SMBus
companion cannot initialize on this machine. Linux consequently falls
back to SynPS/2.

This is particularly noticeable during two-finger scrolling, where the
effective event rate is roughly 40 Hz and scrolling feels significantly
less responsive than when the same class of Synaptics hardware operates
through RMI4/SMBus.

System
------

Machine:
Lenovo ThinkPad L14 Gen 1 AMD

Distribution:
Debian 13 (Trixie)

Kernel:
6.12.107+deb13-amd64

Touchpad:
PNP ID: LEN0411
Synaptics firmware: 10.32
model: 1
id: 0x1e2a1
board id: 3471
fw id: 2909640

SMBus controller:
Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller
PCI ID: 1022:790b
revision: 51
driver: piix4_smbus / i2c_piix4

Relevant boot log
-----------------

piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port selection
piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20

psmouse serio1: synaptics: queried max coordinates: x [..5678], y [..4694]
psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1162..]
psmouse serio1: synaptics: Trying to set up SMBus access
psmouse serio1: synaptics: SMbus companion is not ready yet

psmouse serio1: synaptics: Touchpad model: 1, fw: 10.32,
id: 0x1e2a1,
caps: 0xf014a3/0x940300/0x12e800/0x500000,
board id: 3471,
fw id: 2909640

input: SynPS/2 Synaptics TouchPad

Forcing InterTouch
------------------

I tested:

psmouse.synaptics_intertouch=1

as an actual kernel command-line option at boot.

The parameter is successfully applied, and Linux attempts SMBus access,
but the result remains:

synaptics: Trying to set up SMBus access
synaptics: SMbus companion is not ready yet
input: SynPS/2 Synaptics TouchPad

Therefore this does not appear to be an InterTouch allowlist or kernel
parameter issue.

SMBus capabilities
------------------

The AMD PIIX4 adapters expose SMBus operations but no Host Notify:

Functionalities implemented by /dev/i2c-2:
SMBus Quick Command yes
SMBus Send Byte yes
SMBus Receive Byte yes
SMBus Write Byte yes
SMBus Read Byte yes
SMBus Write Word yes
SMBus Read Word yes
SMBus Block Write yes
SMBus Block Read yes
SMBus Host Notify no

The auxiliary bus used here is:

/sys/bus/i2c/devices/i2c-2/name:
SMBus PIIX4 adapter port 1 at 0b20

Firmware/ACPI information
-------------------------

The Lenovo DSDT explicitly exposes an SMBus device at 0x0b20 with IRQ 7:

Device (SMB1)
{
Name (_HID, "SMB0001")

Name (_CRS, ResourceTemplate ()
{
IO (Decode16,
0x0B20,
0x0B20,
0x20,
0x20
)

IRQ (Level, ActiveLow, Shared, )
{7}
})

Method (_STA, 0, NotSerialized)
{
Return (0x0F)
}
}

However, IRQ 7 is not claimed by the SMBus driver in /proc/interrupts.

Observed input behavior
-----------------------

libinput identifies the devices as:

SynPS/2 Synaptics TouchPad
TPPS/2 Elan TrackPoint

Two-finger touchpad motion produces usable reports at approximately
40 Hz, which makes scrolling visibly/jarringly less smooth.

Single-finger pointing is better, but both the touchpad and TrackPoint
feel noticeably worse than ThinkPads where Synaptics RMI4/SMBus works.

Comparison with another ThinkPad
--------------------------------

For comparison, a ThinkPad T480 running Linux successfully initializes
its Synaptics touchpad through Intel i801 SMBus:

i801_smbus ... SMBus using PCI interrupt
synaptics: Trying to set up SMBus access
rmi4_smbus 0-002c: registering SMbus-connected sensor
rmi4_f01 ... found RMI device
input: Synaptics TM3276-022

The input quality on that system is significantly better.

Existing related work
---------------------

LEN0411 was added to the Synaptics InterTouch SMBus list upstream, but
the original L14 Gen 1 logs associated with that patch already showed:

Trying to set up SMBus access
SMbus companion is not ready yet

and continued to instantiate SynPS/2.

There are also closely related reports from AMD ThinkPad P14s/T14
machines with board ID 3471 where RMI4/SMBus cannot be used successfully.

This appears to point below psmouse itself, possibly toward missing
SMBus Host Notify/interrupt support for this AMD FCH controller in
i2c_piix4.

Questions
---------

1. Is the lack of I2C_FUNC_SMBUS_HOST_NOTIFY in i2c_piix4 the expected
reason the Synaptics RMI companion cannot initialize here?

2. Is support for Host Notify on AMD FCH 1022:790b feasible using the
SMB0001 ACPI resource (0x0b20 / IRQ 7)?

3. Is there existing work toward supporting this controller, or another
supported transport that should be used for LEN0411?

4. I am willing to test proposed patches on this machine.

I can provide the complete DSDT, dmesg, kernel configuration, libinput
output, evtest traces, lspci output, and SMBus capability information if
useful.

Thanks.
