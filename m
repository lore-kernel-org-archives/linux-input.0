From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Thu, 7 May 2009 22:52:12 -0700
Message-ID: <d6200be20905072252p494eec8fmda993ad08fb2c9a7@mail.gmail.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com>
	<5d5443650905070141k2d6e3cb8r9e923c71c5474e43@mail.gmail.com>
	<f17812d70905070148s47045998mfcbbe65b0d8d07b0@mail.gmail.com>
	<5d5443650905070151s2cba17ecm1f829e2fdfb0d0c9@mail.gmail.com>
	<f17812d70905071829j758ee376gbf5564881f186937@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <f17812d70905071829j758ee376gbf5564881f186937@mail.gmail.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-input@vger.kernel.org

On Thu, May 7, 2009 at 6:29 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Thu, May 7, 2009 at 4:51 PM, Trilok Soni <soni.trilok@gmail.com> wrote:
>> Hi Eric,
>>
>> On Thu, May 7, 2009 at 2:18 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>>> On Thu, May 7, 2009 at 4:41 PM, Trilok Soni <soni.trilok@gmail.com> wro=
te:
>>>> Hi Eric,
>>>>
>>>> On Thu, May 7, 2009 at 1:30 PM, Eric Miao <eric.y.miao@gmail.com> wrot=
e:
>>>>> Original patch by Marek Vasut, modified by Eric in:
>>>>>
>>>>> 1. use delayed work to simplify the debouncing
>>>>> 2. build keycode array for fast lookup
>>>>> 3. combine col_polarity/row_polarity into a single active_low field
>>>>> (are there some cases where the GPIOs are externally connected
>>>>> with an inverter and thus causing two different polarity requirement?=
?)
>>>>> 4. use a generic bit array based XOR algorithm to detect key press/re=
lease,
>>>>> which should make the column assertion time shorter and code a bit
>>>>> cleaner
>>>>> 5. remove the ALT_FN handling, which is no way generic, the ALT_FN
>>>>> key should be treated as no different from other keys, and translation
>>>>> will be done by user space by commands like 'loadkeys'.
>>>>>
>>>>> Patch tested on Littleton/PXA310 (though PXA310 has a dedicate keypad
>>>>> controller, I have to configure those pins as generic GPIO to use this
>>>>> driver, works quite well, though ;-)
>>>>
>>>> Any support about removing/clearing ghost/phantom keys? Also we assume
>>>> that all gpios in the matrix should be able to generate interrupts so
>>>> no polldev support required.
>>>>
>>>
>>> Is there some info about such ghost/phantom keys? Otherwise I'll
>>> assume these are something like sticky control keys?
>>>
>>> I'm not sure if there're any such support in console tools and in
>>> input subsystem. Hard to say...
>>>
>>> And the comments below are of great value, I'll incorporate these
>>> suggestions in later submission. Thanks very much.
>>>
>>
>> Could you please have look at following gpio_matrix driver?
>>
>> gpio_matrix.c:
>> http://android.git.kernel.org/?p=3Dkernel/msm.git;a=3Dblob;f=3Ddrivers/i=
nput/misc/gpio_matrix.c;h=3Dc1f47651a4937d5c976a9625ca5da389dd7e4a7c;hb=3DH=
EAD
>>
>> gpio_input.c:
>> http://android.git.kernel.org/?p=3Dkernel/msm.git;a=3Dblob;f=3Ddrivers/i=
nput/misc/gpio_input.c;h=3D7e307f267a2a059b64a3fb9c8a379b149016b2f8;hb=3DHE=
AD
>>
>
> Mmm... looks not so generic, though. And I still have no idea
> about how its phantom key works unless I see its hw.
>

There should be no hardware specific code in those drivers, and you
are free to use them. If you remove the early suspend and wakelock
code and replace disable_irq with disable_irq_nosync it may cover your
needs. We used to have a separate gpio_matrix (and gpio_keys) like you
are proposing to add, but it proved to be too limited since the
hardware vendors like to mix direct gpio keys and and matrix keys in
the same logical keypad.

For the phantom key problem, this occurs with most matrix based
keypads/keyboards. For instance, you press two keys in the same row
then a third key in another row, but in the same column as one of the
first two keys. The driver cannot tell which of the two column you
pressed since the current will flow through the first two keys to or
from the other column. If you do not have any code to detect this you
will report four keys down.

-- =

Arve Hj=F8nnev=E5g

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
