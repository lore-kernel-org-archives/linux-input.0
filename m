From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [linux-usb-devel] Oops in khubd
Date: Mon, 4 Jun 2007 10:10:00 -0400
Message-ID: <d120d5000706040710t4640acb2j14a1f24cfe94311b@mail.gmail.com>
References: <200706031240.43330.mb@bu3sch.de>
	 <Pine.LNX.4.64.0706041335320.29896@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0706041335320.29896@twin.jikos.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Michael Buesch <mb@bu3sch.de>, linux-usb-devel@lists.sourceforge.net, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi,

On 6/4/07, Jiri Kosina <jikos@jikos.cz> wrote:
> This is probably rather related to something in input. Some CCs added and
> original message preserved below.
>
> I think that struct input_dev passed from hidinput_disconnect() should not
> be the corrupted one, as it is dereferenced sooner on the codepath and it
> doesn't go oops.
>

I think this commit should help:

http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=commit;h=fe838febd49be7b8013ae433a6424693180333b5

I just asked Linus to pull it so 2.6.22 does not crash so often while
I am fixing locking properly for 2.6.23.

-- 
Dmitry
