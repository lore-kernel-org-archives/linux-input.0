From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: Handling special keys in platform drivers
Date: Sat, 14 Jan 2012 09:58:58 +0100
Message-ID: <CAHR064gU8MA9SuBFnGf47qH=AmKEeXA=NfsJAZ=YR9hWZxXAuA@mail.gmail.com>
References: <CAHR064jAJkQCd_Tsrx7NHe_RbaBbNcX4sMwy=zkZCZNUNo=fAw@mail.gmail.com>
	<20120113224211.GB29022@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20120113224211.GB29022@srcf.ucam.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jan 13, 2012 at 11:42 PM, Matthew Garrett <mjg@redhat.com> wrote:
> On Mon, Jan 09, 2012 at 07:24:14AM +0100, Corentin Chary wrote:
>
>> The real problem is that for keyboard backlight to work, it needs DE
>> cooperation, and only gnome as implemented that right now, and other
>> (except KDE) will probably neither have the resources to handle all
>> the possible keys correctly. And of course, who should handle the keys
>> when there is no DE running at all ?
>
> The problem with handling this in kernel is that there isn't an
> obviously correct policy. ACPI will typically only expose 16 or so
> backlight levels so the behaviour is easy enough, but (depending on how
> the hardware is wired up) i915 may expose around 20,000. Further, one
> machine may expose different backlight controls for different displays,
> and in that situation you need to know which one the input event is
> expected to correspond to.
>
> Doing backlight control properly involves a lot of policy work, and I'm
> reluctant to argue that that ought to be in the kernel.

But in the case of asus-wmi, that handle both the keys and the
keyboard_backlight, could such handling be done in the kernel ?

-- 
Corentin Chary
http://xf.iksaif.net
