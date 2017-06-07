From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 7/8] greybus: hid: remove custom locking from gb_hid_open/close
Date: Wed, 7 Jun 2017 15:32:56 +0530
Message-ID: <CAOh2x=n9YVoPNKGJ3KwoHomje53BPEAYp9ewVrgBmi2imL-fcA@mail.gmail.com>
References: <20170607065938.33332-1-dmitry.torokhov@gmail.com> <20170607065938.33332-8-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170607065938.33332-8-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

On Wed, Jun 7, 2017 at 12:29 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Now that HID core enforces serialization of transport driver open/close
> calls we can remove custom locking from greybus hid driver.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/staging/greybus/hid.c | 43 ++++++++++++++-----------------------------
>  1 file changed, 14 insertions(+), 29 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
