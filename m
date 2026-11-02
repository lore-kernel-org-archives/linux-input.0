Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.251.234.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793629349;
	b=jtAwQuPJDM+ji18t1gmxLPSlP23HbjxZyYd1scCzLDewk/o3j5rTlnVuP7HrAnmVrTx9
	 T4+E4BrCzSnAzPgHVfzt2e41v/yNrsVRi9BQlYa5Jpq9OaGENpHdlCgSyaPQfwGVR8o01
	 9Bs8QV57Vl0iNmD4L0bb1Rhw1jJWC7EkSluth6PFCqO0lv+TXL3ogF0VP8A5tf57/3IJs
	 HAAthxc1Koue8RM7J9brAHsEVZzxIlk8eOno8bMq8F1eJPkP+iSPG8xJ222xuRqlDvUOh
	 SpuhtXsIRS7fqCFlNXaAKawj7TSca4bnjmLj8OTygoBClcnYhnQc+F4U/hCAIpWsWLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629349;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Read-Receipt-To:
	 X-Confirm-Reading-To:X-Correlation-ID:From:To:Cc:Subject:Message-ID:
	 Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID:
	 X-SES-Outgoing;
	bh=/DnZ3oSTwAvlrsrGpdGsJBnFUEZg4c4com/5I2PFMy0=;
	b=QN2tLFWtAZTx6mVOOIdLrJMlQpOCd1s3BLBuSAZzbBQniXsQwgpmk71AxFxP8fwpEDlj
	 6oIajQyX23JdJEIOYenBenrzbAidgAD5FJ11/7/t+fzUKxiFt+eu0248Ab7gsxTKqkp6F
	 0TNdvMUKvHJRBhh1cw8/fQfNnXHRjymqh8kPg6rZc3Ock3C3iqSbvP1CxdNwfIRE+xYpQ
	 wKQP1V8HlMjDFYa4gONcEWvUv9n2RR1usCSpOrb9/GqlwFckGL41G1gtC1Mg2O17SGQ7v
	 v+CmR9fN3lL8dsQXcubBDJFKlHnKfcqaAuUdAF+3wmuAqlbYuIq4Je0QRHg3VdR8tdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rokokol.art;
	spf=pass smtp.mailfrom=send.rokokol.art;
	dkim=pass header.d=rokokol.art header.i=@rokokol.art header.a=rsa-sha256 header.s=resend header.b=ZiYTdwjw;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b="b/XWXoES";
	arc=none smtp.remote-ip=23.251.234.60
Received: from e234-60.smtp-out.ap-northeast-1.amazonses.com (e234-60.smtp-out.ap-northeast-1.amazonses.com [23.251.234.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11CD60A383E;
	Mon,  2 Nov 2026 14:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C11CD60A383E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rokokol.art
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.rokokol.art
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rokokol.art header.i=@rokokol.art header.a=rsa-sha256 header.s=resend header.b=ZiYTdwjw;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=b/XWXoES
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=rokokol.art; t=1793629347;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=X1y+4EfaPE2UAnaR/qUwVOgNS/yM2KKVP2rweeHr9yk=;
	b=ZiYTdwjwaGw6tZXOwkYJ7xlxh0ZuWLCcoq5PPSyBdQM4lYKI42zALAzUUFIzXlDh
	/Cu8/iI97zBQ8lZednjyjrS4MyWFYWSXtPUFuPmSXOOXYoUpb28eK+eR6ASTRMwGkT/
	p8XJISNbLjfVSqpM3wYmGXl2zGM95gXl2BLkw6Pc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1793629347;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=X1y+4EfaPE2UAnaR/qUwVOgNS/yM2KKVP2rweeHr9yk=;
	b=b/XWXoES3NQhmafaBEi7gc8HXfmdYPqb4uJ5dtvkXIfznyCM+0s8ZSZQMi32BC6u
	9tZd6Z2OCFLMaMJx+hYJKFvnW4PsWqSQLJ+1mqpdMH+OeDYNKRHIuwqRwxTgQ5TJWuC
	nF2KRwFjeNALlagLOyGEAKf/iYUZu8OcFTMm2Mto=
Read-Receipt-To: work@rokokol.art
X-Correlation-ID: <cb331d33-3adf-4e5c-9ad4-bc75d89363ce@rokokol.art>
From: work <work@rokokol.art>
To: linux-acpi@vger.kernel.org
Cc: linux-input@vger.kernel.org
Subject: [REGRESSION] ACPI: button: lid switch emits no SW_LID events after
 the move to the platform bus
Message-ID: <010601a19ca3de07-739bccf6-3a29-486f-b31e-1c928fe27e10-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 2 Nov 2026 14:22:27 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.J1Qr5JqhopftNTv8mDH0t+znTOPY6sk8CO0Y9ds1Y5Cth3IhzujyB8QbxM6EH4Osify1nw21MPpeiTEcUSGfyfKZJsHqoQdtR65LA6WPpV32pqvJWprNzOeiKWx4W8V3uXIXQllynhV8LIFUhwLXeD3SYMr1gBw24SwqBu29Fk+ISIkUjDFiLLSonTfootFH:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.11.02-23.251.234.60


   Hi,
  =20

  =20

   the lid switch on this laptop stopped producing =
SW_LID events after the
  =20

   acpi_button driver moved from =
acpi_bus_register_driver() to
  =20

   platform_driver_register(). 6.18.55=
 works, 6.18.58 and 6.18.59 do not,
  =20

   6.12.114 works. The device =
stays bound, the input node exists and
  =20

   advertises SW_LID, the =
firmware still reports the lid state through _LID,
  =20

   and the power button on the same module keeps working.
  =20

  =20

   Machine: FUJITSU CLIENT COMPUTING LIMITED LIFEBOOK T939/FJNB2CD
  =20

   BIOS: version 2.17, 12/07/2022
  =20

   Distribution: NixOS unstable. =
nixpkgs applies three patches to the kernel
  =20

   =
(randstruct-provide-seed-5.19, request-key-helper, bridge-stp-helper);
  =20

   none of them touches ACPI, so the driver code is the vanilla one.
  =20

   CONFIG_ACPI_BUTTON=3Dm, and /proc/cmdline carries no button.* =
parameter, so
  =20

   the module defaults apply: lid_init_state=3Dmethod,=
 lid_report_interval=3D500.
  =20

   Userspace is systemd 262, where =
logind subscribes to the lid device
  =20

   through libudev.
  =20

  =20

   Works: 6.18.55, 6.12.114
  =20

   Fails: 6.18.58, 6.18.59
  =20

  =20

   Problem:
  =20

  =20

   On 6.18.58 and 6.18.59 the kernel emits no =
SW_LID event when the lid
  =20

   moves, so systemd-logind never logs =
"Lid closed." and the machine does
  =20

   not suspend. The compositor =
receives no switch event either. The power
  =20

   button handled by the =
same driver keeps working.
  =20

  =20

   Steps to reproduce:
  =20

  =20

   =C2=A0 1. Boot 6.18.58 or 6.18.59, with lid_init_state=3Dmethod =
and
  =20

   =C2=A0=C2=A0=C2=A0=C2=A0 lid_report_interval=3D500
  =20

   =C2=A0 2. Find the lid node:
  =20

   =C2=A0=C2=A0=C2=A0=C2=A0 ls -l =
/dev/input/by-path/platform-PNP0C0D:00-event
  =20

   =C2=A0 3. Run evtest on that node
  =20

   =C2=A0 4. Close the lid, =
then open it
  =20

   =C2=A0 5. Read /proc/acpi/button/lid/LID/state at =
the same time
  =20

  =20

   Result:
  =20

  =20

   /proc/acpi/button/lid/LID/state turns open -> closed -> open. That file
  =20

   evaluates _LID on each read, so the firmware still reports the =
lid state.
  =20

   evtest prints nothing, and logind logs nothing.
  =20

  =20

   Expected:
  =20

  =20

   evtest prints SW_LID with value 1 on =
the close and 0 on the open.
  =20

   logind logs "Lid closed." and =
suspends.
  =20

  =20

   What I ruled out:
  =20

  =20

   =C2=A0 - Firmware: the state file flips on a real lid close, so the BIOS=
 and
  =20

   =C2=A0=C2=A0=C2=A0 the EC still evaluate _LID correctly
  =20

   =C2=A0 - The input device: "Lid Switch" exists and advertises =
SW_LID
  =20

   =C2=A0=C2=A0=C2=A0 (EV=3D21 SW=3D1)
  =20

   =C2=A0 - logind: it opens the device at boot and says so ("Watching =
system
  =20

   =C2=A0=C2=A0=C2=A0 buttons on /dev/input/eventX (Lid =
Switch)"). It still receives the
  =20

   =C2=A0=C2=A0=C2=A0 power button =
from the same module, so its event loop is healthy
  =20

   =C2=A0 - Event stealing: no process holds EVIOCGRAB on the lid node. A =
test
  =20

   =C2=A0=C2=A0=C2=A0 program acquires the grab successfully, =
so another reader is not
  =20

   =C2=A0=C2=A0=C2=A0 taking the events
  =20

   =C2=A0 - Node identity: the failing kernel creates exactly one =
device with
  =20

   =C2=A0=C2=A0=C2=A0 SW_LID set (EV=3D21 SW=3D1 on "Lid=
 Switch"). The other switch node,
  =20

   =C2=A0=C2=A0=C2=A0 Intel =
Virtual Switches, carries SW=3D2 only, so it cannot report the
  =20

   =C2=A0=C2=A0=C2=A0 lid
  =20

  =20

   The driver difference:
  =20

  =20

   The input device changed its parent between the working and the =
failing
  =20

   kernel:
  =20

  =20

   =C2=A0 6.18.55:=C2=A0 input: Lid=
 Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input9
  =20

   =C2=A0 6.18.58:=C2=A0 input: Lid Switch as /devices/platform/PNP0C0D:00/=
input/input7
  =20

   =C2=A0 6.18.59:=C2=A0 input: Lid Switch as =
/devices/platform/PNP0C0D:00/input/input9
  =20

   =C2=A0 6.12.114: input:=
 Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input8
  =20

  =20

   The working and the failing modules carry the same strings=
, the same DMI
  =20

   quirks and the same parameters. Both install a =
notify handler. Only the
  =20

   driver model differs:
  =20

  =20

   =C2=A0 6.18.55 and 6.12.114: __acpi_bus_register_driver, acpi_button_add=
,
  =20

   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 acpi_button_notify, acpi_button_notify_run
  =20

   =C2=A0 6.18.59:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 __platform_driver_register, acpi_button_probe,
  =20

   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 acpi_button_notify, acpi_button_notify_run
  =20

  =20

   Suspected cause:
  =20

  =20

   acpi_button_probe may install the =
notify handler on a handle the firmware
  =20

   never notifies, or the =
ACPI companion lookup on the platform device
  =20

   resolves to a different object. Either would leave the driver silent
  =20

   while it is bound and the input device exists.
  =20

  =20

   Not measured yet:
  =20

  =20

   =C2=A0 - Whether the notification =
reaches the driver at all. The ACPI GPE
  =20

   =C2=A0=C2=A0=C2=A0 =
counters do rise during a lid change, but the background rate is
  =20

   =C2=A0=C2=A0=C2=A0 about 1.9 events a second, so the burst needs a =
per-second sample to
  =20

   =C2=A0=C2=A0=C2=A0 be attributed to the lid
  =20

   =C2=A0 - A reader watching every evdev node. It ran on the =
failing kernel, but
  =20

   =C2=A0=C2=A0=C2=A0 the lid did not move =
inside its window, so its result is pending
  =20

  =20

   I can attach a button.ko symbol dump for 6.18.55, 6.18.58, 6.18.59 and
  =20

   6.12.114, and the output of a test program that samples
  =20

   /proc/acpi/button/lid/LID/state, the SW events of every evdev node and
  =20

   the per-second ACPI GPE counters.
  =20

  =20

   --
  =20

   Ilya Leshenko
  =20

 =20
