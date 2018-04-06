From: Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [PATCH 2/2] HID: i2c-hid: Silently fail probe for CHPN0001
 touchscreen
Date: Fri, 6 Apr 2018 20:05:33 +0000
Message-ID: <MW2PR2101MB1034700D2EE61E78EA6C13E7FBBA0@MW2PR2101MB1034.namprd21.prod.outlook.com>
References: <20180403131634.13187-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180403131634.13187-2-hdegoede@redhat.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Sasha Levin <Alexander.Levin@microsoft.com>, Jiri Kosina <jikos@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

[This is an automated email]

This commit has been processed by the -stable helper bot and determined
to be a high probability candidate for -stable trees. (score: 20.8863)

The bot has tested the following trees: v4.16, v4.15.15, v4.14.32, v4.9.92,=
 v4.4.126.

v4.16: Build OK!
v4.15.15: Build OK!
v4.14.32: Build OK!
v4.9.92: Failed to apply! Possible dependencies:
    94116f8126de ("ACPI: Switch to use generic guid_t in acpi_evaluate_dsm(=
)")

v4.4.126: Failed to apply! Possible dependencies:
    94116f8126de ("ACPI: Switch to use generic guid_t in acpi_evaluate_dsm(=
)")


Please let us know if you'd like to have this patch included in a stable tr=
ee.
