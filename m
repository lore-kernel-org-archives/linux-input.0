From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [BUG] i2c-hid: ELAN Touchpad does not work on ASUS X580GD
Date: Tue, 8 May 2018 17:31:16 +0300
Message-ID: <a9e1f1cb-b823-8690-930f-f7346798341a@linux.intel.com>
References: <CAPpJ_ed-JPOzQPtyCdH4_C7dzEeM3fznus8XDuaojaiM_4nFpw@mail.gmail.com>
 <CAB4CAwcKu88xP0R9P-3csd6SE2fZ-Vb6OrQD9AmBDh6p77VFDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAB4CAwcKu88xP0R9P-3csd6SE2fZ-Vb6OrQD9AmBDh6p77VFDQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Chiu <chiu@endlessm.com>, Jian-Hong Pan <jian-hong@endlessm.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jani Nikula <jani.nikula@intel.com>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Adrian Salido <salidoa@google.com>, Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Daniel Drake <drake@endlessm.com>, Linux Upstreaming Team <linux@endlessm.com>
List-Id: linux-input@vger.kernel.org

Hi

On 05/07/2018 11:07 AM, Chris Chiu wrote:

>> Besides, according to ASUS's input, they observed that after entering
>> the OS, the frequency of SCL is too fast (about 600kHz) and the SCL High
>> time is around 450ns, not following I2C spec which is 0.6us.
>> https://pasteboard.co/HjzSWXd.png
>>
> Some update, we can make the touchpad work by simply modifying the
> clk_rate of spt_i2c_info from 120000000 to 133000000 in intel-lpss-pci.c for
> specific PCI ID 8086:a368 ~ a36a (CoffeeLake). Is the clock setting different
> for the CoffeeLake series?
> 
Hmm.. at quick look it looks like to be 133 MHz but I want to double 
check first from other specs. I'm also wondering why it results 600 kHz 
instead of expected 133/120 * 400 kHz = 443 kHz. Need to check timing 
parameters too.

-- 
Jarkko
