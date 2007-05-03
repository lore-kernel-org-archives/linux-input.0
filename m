From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Add wireless and bluetooth keycodes
Date: Thu, 3 May 2007 07:58:45 -0400
Message-ID: <d120d5000705030458m7909bc5enc2ff6621f542c7cf@mail.gmail.com>
References: <200705031215.16971.cathectic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200705031215.16971.cathectic@gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Carlos Corbacho <cathectic@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Carlos,

On 5/3/07, Carlos Corbacho <cathectic@gmail.com> wrote:
> Add wireless and bluetooth keycodes.

Already have them:

#define KEY_BLUETOOTH           237
#define KEY_WLAN                238

> Also, add keycodes for these
> keys having a separate off state (This is true on some machines,
> such as many Acer laptops).
>

Not sure why this is needed.

-- 
Dmitry
