From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 07/12] Input: synaptics - rename synaptics_data.mt to agm
Date: Tue, 5 Jul 2011 12:39:58 +0800
Message-ID: <CAGS+omCGt_oqkuWPdAtXfuWMvWAD5kL9oxRLmKroRSfLAk8VGg@mail.gmail.com>
References: <1309324042-22943-1-git-send-email-djkurtz@chromium.org>
 <1309324042-22943-8-git-send-email-djkurtz@chromium.org> <20110704212640.GD23915@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:18516 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067Ab1GEEkX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 00:40:23 -0400
Received: from kpbe14.cbf.corp.google.com (kpbe14.cbf.corp.google.com [172.25.105.78])
	by smtp-out.google.com with ESMTP id p654eK8j023420
	for <linux-input@vger.kernel.org>; Mon, 4 Jul 2011 21:40:21 -0700
Received: from yxn22 (yxn22.prod.google.com [10.190.4.86])
	by kpbe14.cbf.corp.google.com with ESMTP id p654eJ5g027182
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 4 Jul 2011 21:40:19 -0700
Received: by yxn22 with SMTP id 22so571897yxn.14
        for <linux-input@vger.kernel.org>; Mon, 04 Jul 2011 21:40:19 -0700 (PDT)
In-Reply-To: <20110704212640.GD23915@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: dmitry.torokhov@gmail.com, chase.douglas@canonical.com, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

On Tue, Jul 5, 2011 at 5:26 AM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
> On Wed, Jun 29, 2011 at 01:07:17PM +0800, djkurtz@chromium.org wrote:
>> From: Daniel Kurtz <djkurtz@chromium.org>
>>
>> Rename the synaptics_data.mt field to priv->agm to indicate it is th=
e
>> hardware state reported in a synaptics AGM packet.
>>
>> When a Synaptics touchpad is in "AGM" mode, and multiple fingers are
>> detected, the touchpad sends alternating "Advanced Gesture Mode" (AG=
M) and
>> "Simple Gesture Mode" (SGM) packets.
>> =A0 The AGM packets have w=3D2, and contain reduced resolution finge=
r data.
>> =A0 The SGM packets have w=3D{0,1} and contain full resolution finge=
r data.
>>
>> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
>> ---
>
> How about just modifying the comment, i.e., leaving this hunk?

IMHO, changing the field name from mt to agm makes the following
patches more clear, by making it easier to see the difference between
sgm and agm packets.

>
>> @@ -147,7 +147,7 @@ struct synaptics_data {
>>
>> =A0 =A0 =A0 struct serio *pt_port; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
/* Pass-through serio port */
>>
>> - =A0 =A0 struct synaptics_hw_state mt; =A0 =A0 =A0 =A0 =A0 /* curre=
nt gesture packet */
>> + =A0 =A0 struct synaptics_hw_state agm; =A0 =A0 =A0 =A0 =A0/* last =
AGM packet */
>> =A0};
>>
>> =A0void synaptics_module_init(void);
>> --
>
> Thanks,
> Henrik
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
