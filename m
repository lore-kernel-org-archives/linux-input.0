From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] input: fix broken behaviour of Dell Latitude special keys
Date: Tue, 12 Jun 2007 01:27:24 -0400
Message-ID: <200706120127.25581.dtor@insightbb.com>
References: <929318d30706101042q25418f9aif7c1a609fd792830@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <929318d30706101042q25418f9aif7c1a609fd792830@mail.gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: giel@caffeinetrip.com
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, Vojtech Pavlik <vojtech@suse.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, Matt Domsch <matt_domsch@dell.com>, Rezwanul Kabir <rezwanul_kabir@dell.com>
List-Id: linux-input@vger.kernel.org

Hi,

On Sunday 10 June 2007 13:42, Giel de Nijs wrote:
> Hi,
> 
> Following up on http://thread.gmane.org/gmane.linux.kernel.input/1375 here's
> a new patch to fix the fact that most Fn+F? special keys on (at least) the
> Dell Latitude laptops don't generate a key release event.

Thank you for the patch. Is there any way I could see data coming from i8042
when you press on these special keys? If you could do:

echo 1 > /sys/module/i8042/parameters/debug
tehn presses and released all these keys
echo 0 > /sys/module/i8042/parameters/debug

and send me dmesg I woudl appreciate that.

-- 
Dmitry
