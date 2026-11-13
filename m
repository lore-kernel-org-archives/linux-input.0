Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602436;
	b=bG86MFm3LfoX2Y++H7StIkFc0tfttJQ4dramXZ99LUh8QWYqCT8tsITpDDQ3HCsQx4Yf
	 d2Ptaqj1WcRHLClFiUMJax7EtQor5MzcPDnxKiGlHG3drjQl5M/wXTDAbKxTGFONOb2a7
	 L37wP0zhD9mU6cm09DfgxKQn/q1RX6RVH/wN9wcl0r9md8pcU5Xbh0Ibndfwe21xFZS/d
	 Zojs/qrWaEcSFNciihAgtPq1rhD6vDnD5d42g897N/z8F+gcMdFrrqmkWxhIU2bHuD+KU
	 opsoqb2XG55pfXX2mFkAESAPdLm2xEnuKzROVfGzK+ySYVBirVbiGZbDSoCQZG2cWEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602436;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YqOyLeJF1LZn52GyfM0b3GDfTRLm5jSkYKCfEBCotc0=;
	b=V7lB6YA3pCj4CaMf4iakznPZymOOFw5aBDTTioE2kE4u7XFSzeEw+kZjqVWU1z6atuHb
	 h4QFte4uulyLBmkD1QiQwfx7irfPuvGbt7E8B7p9/S66nFyMc0df5Yc4GeEHDWhHsS8vd
	 J1E676BaMNzCuBSDQ0gMh6GFlMc/e5LeYOp3TSuXB+gViJmM+MqiUVMcew6c8v7+JaOsY
	 IJazjMzUPpNE6ruxGRDtDkatzhla+OKwLXg6uzP9I7cksA2pFFP4kRFMyt6Cfgg0AUx1E
	 Nq8iR0B10px8AIW9zu6xZ6j+5+lIT4mG0F4q8LDb+sJp9gY9BtTnoHKA13owQXRerXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gompa.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.167.178
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB12606A33A
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 20:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCB12606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-51f2e9e6987so2451786b6e.1
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 12:40:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794602434; x=1795207234;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YqOyLeJF1LZn52GyfM0b3GDfTRLm5jSkYKCfEBCotc0=;
        b=tn0jg4ksWVnEkMEpBrrts39OtHQ21wRixjXxJ4+FoB+St/Yut5NtAPdIWxwEbnK1lO
         2FvOksOTL5G2nWbVwCMcxuR/s9kBOOHWN8M6Qx6iGBq8lKDICEH6dhpVbhaxCqx+Mi72
         ZJroz47a2whYQM8cRZetZkKfUJUjuIAfrp1MsdsgDjih2Fc8x+vfXI1c1W4srrGhFErT
         DylQHlFRjGyDQHc47e2UCn15E9SELx4SSjRB5/5xr6PFVSVAvxdnzz03BFdTCha2dje9
         XxGa4SDcdzbVJXFV+KfrWKNv+WPHpXiurvjWwb02QqDmQIMx/VYSXOPhvKaBuuBhCjtT
         WBtg==
X-Forwarded-Encrypted: i=1; AL+hErG6JUwneMZTipW6MngXLnl72ODx4Znfz9j9V8H+4Og9Tr13mbQWpvjjjg3ZDP+EbC0gjNdK1YPEuSXhsQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/MO8mWenW5bK91Sh3Yg3BXjNWVHR5j1DspTf9jQCtV5WiINeZ2
	Z1rGtiOVxejnGoh+L8rBFIHdcnKb6lzrjnnzwyFMnJUAyZHg+4UOF0E9vXyKZKLM
X-Gm-Gg: AYBFou1Qf8XuJ9Y4hgilP29sFho6cMohrmBgB8+op80fU9r/pQ+8psRWBZfA04XTw5G
	yy23lhYZJahwSC54RxB1u3eR7IuWXePPaQLDLexMaDe9eYwRc4gTNkXSsNNeYCRW267wud6506z
	7ldfqTYPElnf7h4I0zWLu5nd7k3ElQDhXRP4S1g3HQACQ4FPqtWV/Zd8/UOlzz6L8spSnDUHYKT
	/1rs3UJvvbKNWeqGeFKbbAt8bB2ZJblAVaIh6nDNFgOD3ApA8iJEI0ObDDTzQcfvxGlgpGL/8JN
	rKDuQXXGzu6HvvmQQof1y+lhdHrkvma0DxFY/QK2aBFvMDi6tPL6UcS6rVX/DmYmcAVuhW0t9sy
	yNvkxo0h3iXNVQuX5XNEOnZrNuRJtw2xw5lJ5rLe+8FhGu0hFHp5E05eS/hU+saXgXLhmfHh1uS
	5TarxeA1xVt+V3OrccPOBER6Wha2AKiSMxxZ6d43NWc76ZGO/2TVio5+7EEoSQA6mKTv3mEo5ip
	mIGYW3K15JnT56rHG62sbKDGz+z14WF2dQXhbvc2IZgZKYwbSHEHmxYF+N+Hurui6EKWA5qiPNv
	19uOYGM4LLdUn9+KKRQTOmzU3+Nc8YVCyyOCrocLf85I6akFkN4EkqfsRPyNsx1fVe3Cb5K0SjN
	xtQ2KOCCHGcNSN3mHJzMAWGQPVcZJ201gV5/WC+ontaYhxXRq2HS+ltbw9eukbC20Is6GdXKNkh
	69
X-Received: by 2002:a05:6808:1816:b0:544:9281:a3a9 with SMTP id 5614622812f47-56e65002968mr2431323b6e.19.1794602433568;
        Fri, 13 Nov 2026 12:40:33 -0800 (PST)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e7024673csm2974397b6e.8.2026.11.13.12.40.32
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 12:40:32 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-86103aaac12so2014016a34.0
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 12:40:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFQ7Qml5psTT+1PtcQPBtzlfqc0l8V3WzOKG9D/igX7xmMAVSTlRRDSkuOzRjrrgkuu6amTpQZxbNlgyw==@vger.kernel.org
X-Received: by 2002:a05:6830:1cc2:b0:7f9:555:1df0 with SMTP id
 46e09a7af769-86289878845mr2035460a34.12.1794602431926; Fri, 13 Nov 2026
 12:40:31 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108-b4-apple-mtp-keyboard-v5-0-e2c97b82669a@gmail.com>
In-Reply-To: <20261108-b4-apple-mtp-keyboard-v5-0-e2c97b82669a@gmail.com>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 13 Nov 2026 15:39:55 -0500
X-Gmail-Original-Message-ID: <CAEg-Je9ffh8v9PKn-pRc7DLjD0h9oP64ZB_FR5B0K=YfctJx2w@mail.gmail.com>
X-Gm-Features: AclHuK99xhj_lrjZso--3IknqiDF9swsBuRbZJPQdiHng0qFnjGS4Y8OcMsuew0
Message-ID: <CAEg-Je9ffh8v9PKn-pRc7DLjD0h9oP64ZB_FR5B0K=YfctJx2w@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Add support for Apple Silicon DockChannel internal keyboards
To: michael.reeves077@gmail.com
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	Yureka Lilian <yureka@cyberchaos.dev>, Hector Martin <marcan@marcan.st>, 
	Sasha Finkelstein <k@chaosmail.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 2:25=E2=80=AFAM Michael Reeves via B4 Relay
<devnull+michael.reeves077.gmail.com@kernel.org> wrote:
>
> This series introduces support for the internal keyboards on Apple
> Silicon M2 and M3 MacBook models.
>
> On these platforms, built-in input devices are managed by a dedicated
> coprocessor running an RTKit-based operating system. Communication
> between this coprocessor and the main processor is carried out over a
> low-latency hardware byte FIFO interface called DockChannel.
>
> To support this input path, the series introduces a few new components:
> - An apple-dockchannel mailbox driver to handle the low-level
>   byte-stream FIFO.
> - A DockChannel HID transport driver (apple-hid) that boots the
>   coprocessor using the RTKit framework and encapsulates the HID
>   protocol over the mailbox.
> - Minor additions to the apple-rtkit and hid-apple drivers to support
>   the TraceKit endpoint and integrate the keyboards into the existing
>   input-quirks framework.
> - Devicetree bindings and DTS updates to describe the nodes on M2 and
>   M3 laptops.
>
> The transport driver is based on an original out-of-tree implementation
> by Hector Martin, but it has been significantly rewritten for upstream
> inclusion to use the standard Linux mailbox framework and align better
> with upstream HID design patterns and reduce reliance on hacks.
>
> While the coprocessor manages both the keyboard and the trackpad, this
> series only enables keyboard support. The keyboard can be initialised
> without loading external firmware, whereas the trackpad requires
> firmware. Trackpad support will be submitted in a subsequent series
> once these base transport layers are established.
>
> Tested on: MacBook Air M3 (J613).
>
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
>
> Changes in v5:
> - Link to v4: https://lore.kernel.org/all/20260925-apple-mtp-keyboard-fin=
al-v4-0-304c267518f4@gmail.com/
> - Drop ASC mailbox and DART binding patches which were picked up and are =
in apple-soc/dt-7.5
> - Simplify HID transport reg-names from coproc-asc/sram to asc/sram (sugg=
ested by Rob Herring).
> - Replace the empty STM child node with the 'apple,has-stm' boolean prope=
rty (suggested by Rob Herring).
> - Drop the keyboard child node and move 'hid-country-code' to the parent =
node (suggested by Rob Herring).
> - Simplify the transport driver to filter supported interfaces in C and d=
rop fwnode handling.
> - Collect Reviewed-by from Rob Herring on the DockChannel mailbox binding=
.
> - Rebase on v7.4-rc1
>
> Changes in v4:
> - Link to v3: https://lore.kernel.org/all/20260918-apple-mtp-keyboard-fin=
al-v3-0-e356464e454b@gmail.com/
> - Describe the DockChannel interrupt pair in DT (suggested by Yureka Lili=
an).
> - Serialize command transactions and finish STM setup before signalling r=
eady.
> - Keep IRQ flag reads and acknowledgements under the controller lock.
> - Clarify teardown synchronization and use the explicit-bounds HID API.
> - Preserve interface-start errors and allow waiting again for delayed rea=
diness.
> - Simplify FIFO writes, IRQ startup and compatible matching.
> - The command and IRQ changes address Sashiko feedback.
>
> Changes in v3:
> - Link to v2: https://lore.kernel.org/all/20260918-apple-mtp-keyboard-fin=
al-v2-0-a5c685e50b60@gmail.com/
> - Fix failed-probe cleanup and interface publication ordering.
> - Fix report lengths/types and reject replacement descriptors.
> - Terminate serial replies and encode checksums as little endian.
> - Honor HID_QUIRK_IGNORE_SPECIAL_DRIVER.
> - Clarify the DockChannel TX byte register layout.
> - All changes above address Sashiko feedback.
>
> Changes in v2:
> - Link to v1: https://lore.kernel.org/asahi/20260630-apple-mtp-keyboard-f=
inal-v1-0-506d936a1707@gmail.com/
> - Rebase onto latest upstream and add M3 Pro/Max device-tree support.
> - Use an optional STM node to decide whether to wait for device IDs
>   (suggested by Yureka Lilian).
> - Rename bindings to match the t8112 fallback (suggested by Conor Dooley)=
.
> - Fix FIFO MMIO write width (suggested by Yureka Lilian) and run mailbox
>   interrupt handling in the IRQ thread.
> - Remove the duplicate report fixup (suggested by Sasha Finkelstein)
>   and redundant HID dependency (suggested by Julian Braha).
> - Fix teardown and the missing HID stop callback; simplify interface look=
up.
>
> ---
> Michael Reeves (7):
>       dt-bindings: mailbox: apple: Add DockChannel mailbox
>       dt-bindings: input: apple: Add DockChannel HID transport
>       mailbox: apple: Add DockChannel FIFO controller
>       HID: apple: Add support for DockChannel HID keyboards
>       HID: apple: Add DockChannel HID transport driver
>       arm64: dts: apple: Add MTP DockChannel HID nodes
>       arm64: dts: apple: Enable DockChannel HID on M2 and M3 laptops
>
> Sasha Finkelstein (1):
>       soc: apple: rtkit: Add tracekit endpoint
>
>  .../input/apple,t8112-dockchannel-hid.yaml         |   92 ++
>  .../bindings/mailbox/apple,t8112-dockchannel.yaml  |   88 ++
>  MAINTAINERS                                        |    5 +
>  arch/arm64/boot/dts/apple/t602x-die0.dtsi          |   47 +
>  arch/arm64/boot/dts/apple/t602x-j414-j416.dtsi     |   24 +
>  arch/arm64/boot/dts/apple/t6030.dtsi               |   47 +
>  arch/arm64/boot/dts/apple/t6031-die0.dtsi          |   47 +
>  arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi     |   19 +
>  arch/arm64/boot/dts/apple/t8112-j413.dts           |   19 +
>  arch/arm64/boot/dts/apple/t8112-j415.dts           |   19 +
>  arch/arm64/boot/dts/apple/t8112-j493.dts           |   21 +-
>  arch/arm64/boot/dts/apple/t8112.dtsi               |   47 +
>  arch/arm64/boot/dts/apple/t8122-j504.dts           |   22 +
>  arch/arm64/boot/dts/apple/t8122-j613.dts           |   22 +
>  arch/arm64/boot/dts/apple/t8122-j615.dts           |   22 +
>  arch/arm64/boot/dts/apple/t8122.dtsi               |   48 +
>  drivers/hid/Kconfig                                |    2 +
>  drivers/hid/Makefile                               |    2 +
>  drivers/hid/dockchannel/Kconfig                    |   14 +
>  drivers/hid/dockchannel/Makefile                   |    3 +
>  drivers/hid/dockchannel/apple-hid.c                | 1167 ++++++++++++++=
++++++
>  drivers/hid/hid-apple.c                            |  118 +-
>  drivers/mailbox/Kconfig                            |   12 +
>  drivers/mailbox/Makefile                           |    2 +
>  drivers/mailbox/apple-dockchannel.c                |  357 ++++++
>  drivers/soc/apple/rtkit.c                          |    2 +
>  include/linux/hid.h                                |    1 +
>  include/linux/mailbox/apple-dockchannel.h          |   29 +
>  28 files changed, 2251 insertions(+), 47 deletions(-)
> ---
> base-commit: 1d368e025d7c4fe63c8bf68ccb4bc3c9772ab75c
> change-id: 20261108-b4-apple-mtp-keyboard-94f1cf08ef11
>

Series LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
