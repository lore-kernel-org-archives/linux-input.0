From: Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH 2/2] input: atakbd.c - fix Atari CapsLock behaviour
Date: Tue, 18 Sep 2018 14:03:29 +1200
Message-ID: <136f4a00-ba74-a705-ef31-29c60eb51aa1@gmail.com>
References: <1536277243-3821-1-git-send-email-schmitzmic@gmail.com>
 <1536277243-3821-3-git-send-email-schmitzmic@gmail.com>
 <20180917194310.GA171258@dtor-ws> <87in33hnqj.fsf@igel.home>
 <20180917223627.GC203020@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <bounce-debian-68k=debian-68k=m.gmane.org@lists.debian.org>
In-Reply-To: <20180917223627.GC203020@dtor-ws>
Content-Language: en-US
Resent-Message-ID: <ThsJ8BIMhIF.A.4WE.I0FobB@bendel>
List-URL: <https://lists.debian.org/debian-68k/>
List-Post: <mailto:debian-68k@lists.debian.org>
List-Help: <mailto:debian-68k-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-68k-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-68k-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/136f4a00-ba74-a705-ef31-29c60eb51aa1@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>
Cc: linux-input@vger.kernel.org, debian-68k@lists.debian.org, linux-m68k@lists.linux-m68k.org
List-Id: linux-input@vger.kernel.org

Thanks Dmitry!

I had asked Andreas' signoff for his keymap fixes only - the rewrite of 
the Atari keyboard driver to the current input framework (and hence the 
CapsLock toggle bug) was entirely mine, no blame attaches to Andreas there.

Cheers,

     Michael



On 18/09/18 10:36, Dmitry Torokhov wrote:
> On Mon, Sep 17, 2018 at 10:29:08PM +0200, Andreas Schwab wrote:
>> On Sep 17 2018, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>>
>>> On Fri, Sep 07, 2018 at 11:40:43AM +1200, Michael Schmitz wrote:
>>>> The CapsLock key on Atari keyboards is not a toggle, it does send the
>>>> normal make and break scancodes.
>>>>
>>>> Drop the CapsLock toggle handling code, which did cause the CapsLock
>>>> key to merely act as a Shift key.
>>>>
>>>> Tested-by: Michael Schmitz <schmitzmic@gmail.com>
>>>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>>> Andreas, I have no idea how Atari keyboards work, can you add your
>>> signed-off-by (or NAK) to this one as well please?
>> The old atakbd driver never had that special handling.
>>
>> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> Applied, thank you.
>
