From: Andreas =?iso-8859-1?Q?H=FCbner?= <andreas@k4n.de>
Subject: Re: joydev: support for Saitek PS1000 gamepad
Date: Wed, 23 Nov 2011 09:43:43 +0100
Message-ID: <20111123084340.GA18805@tapura>
References: <20111122102832.GA22152@v36691.1blu.de>
 <95ab6669b51867deb14cdd81c79dead1.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from v36691.1blu.de ([89.202.1.191]:39985 "EHLO v36691.1blu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752287Ab1KWIni (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Nov 2011 03:43:38 -0500
Content-Disposition: inline
In-Reply-To: <95ab6669b51867deb14cdd81c79dead1.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Simon,

thanks for your help!

> If you can post/decode the descriptor that might provide some insight into
> the problem.

I've attached the hid report descriptor in binary and spec format.


Andreas

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="saitek_ps1000.spec"

Usage Page (Desktop),               ; Generic desktop controls (01h)
Usage (Gamepad),                    ; Gamepad (05h, application collection)
Collection (Application),
    Usage (Pointer),                ; Pointer (01h, physical collection)
    Collection (Physical),
        Usage Page (Desktop),       ; Generic desktop controls (01h)
        Usage (X),                  ; X (30h, dynamic value)
        Usage (Y),                  ; Y (31h, dynamic value)
        Usage (Z),                  ; Z (32h, dynamic value)
        Usage (Rz),                 ; Rz (35h, dynamic value)
        Usage (Rx),                 ; Rx (33h, dynamic value)
        Usage (Slider),             ; Slider (36h, dynamic value)
        Logical Minimum (0),
        Logical Minimum (0),
        Logical Minimum (0),
        Logical Minimum (0),
        Logical Maximum (255),
        Logical Minimum (0),
        Logical Minimum (0),
        Logical Minimum (0),
        Logical Minimum (0),
        Logical Minimum (0),
        Logical Minimum (0),
        Logical Minimum (0),
        Logical Minimum (0),
        Logical Minimum (0),
        Logical Minimum (0),
        Logical Minimum (0),
        Logical Minimum (0),
        Logical Maximum (255),
        Physical Minimum (0),
        Physical Maximum (255),
        Unit,
        Report Size (8),
        Report Count (5),
        Input (Variable),
    End Collection,
    Usage (Hat Switch),             ; Hat switch (39h, dynamic value)
    Logical Minimum (1),
    Logical Maximum (8),
    Physical Minimum (0),
    Physical Maximum (315),
    Unit (Degrees),
    Report Size (4),
    Report Count (1),
    Input (Constant, Variable),
    Usage Page (Button),            ; Button (09h)
    Usage Minimum (01h),
    Usage Maximum (0Dh),
    Logical Minimum (0),
    Logical Maximum (1),
    Report Size (1),
    Report Count (13),
    Input (Constant, Variable),
    Report Count (7),
    Input (Constant),
    Usage Page (LED),               ; LEDs (08h)
    Usage (43h),
    Logical Minimum (0),
    Logical Maximum (255),
    Physical Minimum (0),
    Physical Maximum (255),
    Report Size (8),
    Report Count (4),
    Output (Variable, Volatile),
End Collection

--FCuugMFkClbJLl1L
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="saitek_ps1000.bin"
Content-Transfer-Encoding: base64

BQEJBaEBCQGhAAUBCTAJMQkyCTUJMwk2FQAVABUAFQAm/wAVABUAFQAVABUAFQAVABUAFQAV
ABUAFQAm/wA1AEb/AGYAAHUIlQWBAsAJORUBJQg1AEY7AWUUdQSVAYEDBQkZASkNFQAlAXUB
lQ2BA5UHgQEFCAlDFQAm/wA1AEb/AHUIlQSRgsA=

--FCuugMFkClbJLl1L--
