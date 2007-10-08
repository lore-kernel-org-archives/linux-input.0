From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: GeneralTouch USB Touchscreen Support
Date: Mon, 8 Oct 2007 09:23:38 -0400
Message-ID: <d120d5000710080623o4a0be879w45d59be6ee025d40@mail.gmail.com>
References: <f37dba8b0710080305t37b57e3dpe2fd7be231893ba5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <f37dba8b0710080305t37b57e3dpe2fd7be231893ba5@mail.gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: zeylienospam@gmail.com
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Ilya,

On 10/8/07, if <zeylie@gmail.com> wrote:
> Hello!
>
> Sending patch as told to.
> Formal notes:
> Patch made against 2.6.22.9 sources.
> Marketing is lying, quick google for model ( TL6B17S) shows they say
> it has 4096x4096 sensitivity, while device itself do not report more
> than 0x0470 (i set 0x0500 as max), so with monitors greater than 1024
> pixels special calibration is needed.
> I wrote mail to manufacturer asking for linux drivers but got no
> response, so i had no way but to sniff the usb bus and figure out how
> to make the device work, and reversing is not illegal in my country.
> I agree with GPL of course, the following patch can be used according to it ;-)
>

The patch looks good, thanks a lot.

Can I please have your "Signed-off-by:" so I can apply it?  Thanks!

-- 
Dmitry
