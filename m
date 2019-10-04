From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Subject: Re: [PATCH] Input: add input_get_poll_interval()
Date: Fri, 4 Oct 2019 10:09:16 +0200
Message-ID: <d52af5bc-aa1c-c186-e686-de63d66a95b7@ysoft.com>
References: <20191002215812.GA135681@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191002215812.GA135681@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On 02. 10. 19 23:58, Dmitry Torokhov wrote:
> Some drivers need to be able to know the current polling interval for
> devices working in polling mode, let's allow them fetching it.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Just tested to use this function from a mpr121_touchkey driver.
Works as expected. When I change the poll interval from sysfs, the new
value is correctly reported.

Tested-by: Michal Vokáč <michal.vokac@ysoft.com>

> ---
>   drivers/input/input-poller.c | 9 +++++++++
>   include/linux/input.h        | 1 +
>   2 files changed, 10 insertions(+)
