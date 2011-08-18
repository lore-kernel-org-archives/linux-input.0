From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 6/6] Input: elantech - add v3 hardware support
Date: Thu, 18 Aug 2011 13:34:54 +0800
Message-ID: <CAGS+omB0Ys-vEVq64W85Jmsz=TkgvNqn_iJkxynZJr8wvqifGQ@mail.gmail.com>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw>
 <1313632629-23603-7-git-send-email-jj_ding@emc.com.tw> <4E4C80A0.8090708@cn.fujitsu.com>
 <87d3g347ey.fsf@emc.com.tw> <4E4CA3A9.2010900@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4E4CA3A9.2010900@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gaowanlong@cn.fujitsu.com
Cc: JJ Ding <jj_ding@emc.com.tw>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Eric Piel <E.A.B.Piel@tudelft.nl>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>
List-Id: linux-input@vger.kernel.org

On Thu, Aug 18, 2011 at 1:31 PM, Wanlong Gao <gaowanlong@cn.fujitsu.com=
> wrote:
> On 08/18/2011 01:26 PM, JJ Ding wrote:
>>
>> Hi Wanlong Gao,
>>
>> On Thu, 18 Aug 2011 11:01:52 +0800, Wanlong Gao<gaowanlong@cn.fujits=
u.com>
>> =A0wrote:
>>>
>>> On 08/18/2011 09:57 AM, JJ Ding wrote:
>>>>
>>>> v3 hardware's packet format is almost identical to v2 (one/three f=
inger
>>>> touch),
>>>> except when sensing two finger touch, the hardware sends 12 bytes =
of
>>>> data.
>>>>
>>>> Signed-off-by: JJ Ding<jj_ding@emc.com.tw>
>>>> ---
>>>> =A0 Documentation/input/elantech.txt | =A0104 ++++++++++++++++--
>>>> =A0 drivers/input/mouse/elantech.c =A0 | =A0218
>>>> ++++++++++++++++++++++++++++++++++---
>>>> =A0 drivers/input/mouse/elantech.h =A0 | =A0 11 ++
>>>> =A0 3 files changed, 303 insertions(+), 30 deletions(-)
>>>>
>>>> +static int determine_packet_v3(struct psmouse *psmouse)
>>>
>>> elantech_check_parity_v1
>>> packet_simple_check_v2
>>> determine_packet_v3
>>>
>>> Why not consistent them?
>>
>> OK, how do these names sound to you?
>>
>> elantech_check_parity_v1
>> elantech_packet_check_v2
>> elantech_packet_check_v3
>>
>> Thanks,
>> jj
>
> Yeah, sounds perfectly.

Or just:

elantech_packet_check_v1
elantech_packet_check_v2
elantech_packet_check_v3

:)
