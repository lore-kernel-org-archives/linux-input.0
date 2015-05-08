From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v6 05/11] rc: Add HDMI CEC protoctol handling
Date: Fri, 08 May 2015 13:18:16 +0200
Message-ID: <554C9B78.2060808@xs4all.nl>
References: <1430760785-1169-1-git-send-email-k.debski@samsung.com> <1430760785-1169-6-git-send-email-k.debski@samsung.com> <554C97C3.5030806@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <554C97C3.5030806@xs4all.nl>
Sender: linux-media-owner@vger.kernel.org
To: Kamil Debski <k.debski@samsung.com>, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
Cc: m.szyprowski@samsung.com, mchehab@osg.samsung.com, kyungmin.park@samsung.com, thomas@tommie-lie.de, sean@mess.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org, lars@opdenkamp.eu
List-Id: linux-input@vger.kernel.org

On 05/08/2015 01:02 PM, Hans Verkuil wrote:
> On 05/04/2015 07:32 PM, Kamil Debski wrote:
>> Add handling of remote control events coming from the HDMI CEC bus.
>> This patch includes a new keymap that maps values found in the CEC
>> messages to the keys pressed and released. Also, a new protocol has
>> been added to the core.
>>
>> Signed-off-by: Kamil Debski <k.debski@samsung.com>
> 
> Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

But if you could fix the typo in the subject: protoctol -> protocol, then
that would be appreciated...

Regards,

	Hans

> --
> To unsubscribe from this list: send the line "unsubscribe linux-media" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
