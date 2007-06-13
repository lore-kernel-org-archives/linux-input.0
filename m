From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: [patch] hid: fix autocentering of PID devices
Date: Thu, 14 Jun 2007 00:08:13 +0300
Message-ID: <46705CBD.5040302@gmail.com>
References: <466FDC51.5030703@gmail.com> <Pine.LNX.4.64.0706131746020.23280@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0706131746020.23280@twin.jikos.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-input@atrey.karlin.mff.cuni.cz, Diogo Kastrup <dk@bighost.com.br>
List-Id: linux-input@vger.kernel.org

Jiri Kosina wrote:
> On Wed, 13 Jun 2007, Anssi Hannula wrote:
> 
>> When setting the autocentering of PID devices, PID_DIRECTION_ENABLE is 
>> not being explicitely set to 1. This results in autocentering working 
>> only on the vertical axis when this field is preset to 0. This seems to 
>> happen since 2.6.21.
> 
> Hi Anssi,

Hi!

> do you have any idea what caused this to happen in 2.6.21 and not in 
> earlier versions?

Nope. Do you think it would be useful for me to bisect 2.6.20-2.6.21?

-- 
Anssi Hannula
