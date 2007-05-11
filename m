From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: evdev: Fix a buffer overflow on BIG_ENDIAN systems
Date: Fri, 11 May 2007 01:10:24 -0400
Message-ID: <200705110110.24613.dtor@insightbb.com>
References: <200705110054.l4B0sKil026374@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200705110054.l4B0sKil026374@toshiba.co.jp>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: kenichi3.nagai@toshiba.co.jp
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Thursday 10 May 2007 20:54, kenichi3.nagai@toshiba.co.jp wrote:
>  I found a little mistake. 
>  On TOSHIBA Cell refference system(BIG_ENDIAN systems) a buffer overflow
> was occured when I specified smaller buffers than maxlen.
>

Thank you.
 
-- 
Dmitry
