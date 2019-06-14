From: =?UTF-8?Q?Jean=2DBaptiste_Th=C3=A9ou?= <jb@essential.com>
Subject: Regression post "HID: core: move Usage Page concatenation to Main item"
Date: Fri, 14 Jun 2019 09:01:25 +0900
Message-ID: <CAEXycp+Y-x7N_Yr==Xy_CT5K_a1DZYc85w1OUV+cKC5ZN+KB1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, nsaenzjulienne@suse.de
List-Id: linux-input@vger.kernel.org

Hi,

This patch (58e75155009cc800005629955d3482f36a1e0eec) is triggering a
regression with the following descriptor (report not working as
expected)

https://partner-android.googlesource.com/platform/cts/+/refs/heads/q-fs-release/tests/tests/hardware/res/raw/asus_gamepad_register.json

Didn't see anything obviously wrong with this gamepad descriptor, so
not sure what's trigger the regression.

Thanks a lot

Best regards
