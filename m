From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Subject: Re: rmi4 defunct on T460p [was: [git pull] Input updates for v4.15-rc8]
Date: Thu, 1 Mar 2018 14:22:10 +0100
Message-ID: <CAJ+F1CLFE=02hBY8paC83c-GjcPBM3YekAeYwxaporw8QczLFw@mail.gmail.com>
References: <20180119174205.iq76oggc2h7neymf@dtor-ws> <b41e15f7-845a-6873-ddd1-0829b39319a4@suse.cz>
 <20180209013916.GA42766@dtor-ws> <6eb210d1-5b1b-d7ad-6188-e632fde2c6f7@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6eb210d1-5b1b-d7ad-6188-e632fde2c6f7@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, open list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi

On Tue, Feb 13, 2018 at 9:22 AM, Jiri Slaby <jslaby@suse.cz> wrote:
> On 02/09/2018, 02:39 AM, Dmitry Torokhov wrote:
>> On Thu, Feb 08, 2018 at 11:04:22AM +0100, Jiri Slaby wrote:
>>> On 01/19/2018, 06:42 PM, Dmitry Torokhov wrote:
>>>> Please pull from:
>>>>
>>>>     git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-l=
inus
>>>>
>>>> to receive updates for the input subsystem. You will get:
>>>>
>>> ...
>>>> - touchpad on Lenovo T640p is switched over to SMbus/RMI
>>> ...
>>>
>>>> =E7=8E=8B=E6=8C=AF=E6=9D=B0 (1):
>>>>       Input: synaptics - Lenovo Thinkpad T460p devices should use RMI
>>>
>>> Hi,
>>>
>>> one of openSUSE users with T460p reports that the touchpad is defunct
>>> after resume in 4.15. psmouse.synaptics_intertouch=3D0 works around the
>>> problem.
>>>
>>> The problem is:
>>>  kernel: rmi4_smbus 8-002c: failed to get SMBus version number!
>>>  kernel: rmi4_physical rmi4-00: rmi_driver_reset_handler: Failed to rea=
d
>>> current IRQ mask.
>>>  kernel: rmi4_f01 rmi4-00.fn01: Failed to restore normal operation: -16=
.
>>>  kernel: rmi4_f01 rmi4-00.fn01: Resume failed with code -16.
>>>  kernel: rmi4_physical rmi4-00: Failed to suspend functions: -16
>>>  kernel: rmi4_smbus 8-002c: Failed to resume device: -16
>>>  kernel: rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to write to F0=
3
>>> TX register (-16).
>>>
>>> The downstream bug is at:
>>> https://bugzilla.suse.com/show_bug.cgi?id=3D1079862
>>>
>>> Any ideas?
>>
>> Hmm, maybe the seuence between psmouse and rmi/smbus is not quite right
>> on resume on that box. Can you ask the reporter to:
>>
>> echo 1 > /sys/power/pm_print_times
>> suspend/resume
>
> He uploaded it here:
> https://bugzilla.suse.com/attachment.cgi?id=3D759933
>

Same problem (with f27 and upstream kernel), is there anything else we
can do to help? Should we open a bug on http://bugzilla.kernel.org ?

thanks

--=20
Marc-Andr=C3=A9 Lureau
