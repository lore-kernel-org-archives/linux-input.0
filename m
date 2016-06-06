From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/5] Input: alps - cleanup
Date: Mon, 6 Jun 2016 13:32:31 +0200
Message-ID: <b938b267-6d6e-4397-3af2-c76deaae1f38@redhat.com>
References: <1465212241-14702-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465212241-14702-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ben Gamari <ben@smart-cactus.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On 06-06-16 13:23, Pali Roh=C3=A1r wrote:
> This patch series cleanup usage of alps_model_data table.
>
> Pali Roh=C3=A1r (5):
>   Input: alps - move ALPS_PROTO_V6 out of alps_model_data table
>   Input: alps - move ALPS_PROTO_V4 out of alps_model_data table
>   Input: alps - move ALPS_PROTO_V1 out of alps_model_data table
>   Input: alps - warn about unsupported ALPS V9 touchpad
>   Input: alps - cleanup ALPS_PROTO_V2 detection
>
>  drivers/input/mouse/alps.c |   99 ++++++++++++++++++++++++++--------=
----------
>  drivers/input/mouse/alps.h |   10 ++---
>  2 files changed, 62 insertions(+), 47 deletions(-)

Series looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Thanks & Regards,

Hans
